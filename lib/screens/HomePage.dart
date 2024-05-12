import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lawyers_diary/models/date.dart';
import 'package:lawyers_diary/providers/date_provider.dart';
import 'package:lawyers_diary/screens/newCase.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class HomePage extends ConsumerStatefulWidget {
  static const routeName = "/homepage";
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final columns = 7;
  final rows = 5;
  List<List<String>> data = [
    ['1', '2', '3', '4', '5', '6', '7'],
    ['1', '2', ' 3', ' 4', '5', '6', '7'],
    ['1', '2', '3', '4', '5', '6', '7'],
    ['1', '2', '3', '4', '5', '6', '7'],
    ['1', '2', ' 3', ' 4', '5', '6', '7'],
  ];
  var titleColumn = [
    'Court Name',
    'Case No.',
    'Name of Party',
    'Particular',
    'Year',
    'Stage',
    'Next Date'
  ];
  var titleRow = ['p', 'q', 'r', 's', 't'];

  String _getDay(int day) {
    switch (day) {
      case 1:
        return 'MON';
      case 2:
        return 'TUE';
      case 3:
        return 'WED';
      case 4:
        return 'THU';
      case 5:
        return 'FRI';
      case 6:
        return 'SAT';
      case 7:
        return 'SUN';
      default:
        return 'NAN';
    }
  }

  void pickDate(WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBox(ref);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final selectedDay = Provider.of<DateData>(context).selectedDate;
    final selectedDay = ref.watch(DateStateNotifierProvider).selectedDate;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 8),
            child: Text(_getDay(selectedDay.weekday)),
          ),
          InkWell(
            onTap: () {
              pickDate(ref);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                '${DateFormat.yMMMd().format(selectedDay)} ▼',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NewCaseScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: StickyHeadersTable(
                columnsLength: columns,
                rowsLength: rows,
                columnsTitleBuilder: (i) => Text(titleColumn[i]),
                rowsTitleBuilder: (i) => Text(titleRow[i]),
                contentCellBuilder: (j, i) => Text(data[i][j].toString()),
                legendCell: const Text('Previous Date'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DialogBox extends StatefulWidget {
  WidgetRef ref;
  DialogBox(this.ref);
  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    var selectedDay = widget.ref.watch(DateStateNotifierProvider).selectedDate;
    var _focusedDay = selectedDay;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(0),
        child: Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2075),
              availableGestures: AvailableGestures.all,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                  widget.ref
                      .watch(DateStateNotifierProvider.notifier)
                      .setDate(_focusedDay);
                });
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarBuilders: CalendarBuilders(
                todayBuilder: (context, day, focusedDay) {
                  if (isSameDay(day, selectedDay)) {
                    return Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(day.day.toString()),
                      ),
                    );
                  }
                  return Container(
                    margin: const EdgeInsets.all(5),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        child: Text(day.day.toString()),
                      ),
                    ),
                  );
                },
                defaultBuilder: (context, day, focusedDay) {
                  if (isSameDay(day, selectedDay)) {
                    return Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(day.day.toString()),
                      ),
                    );
                  }
                  if (isSameDay(day, DateTime.now())) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          child: Text(day.day.toString()),
                        ),
                      ),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.all(3),
                    child: Center(
                      child: CircleAvatar(child: Text(day.day.toString())),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
