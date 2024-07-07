import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lawyers_diary/controllers/case_controller.dart';
import 'package:lawyers_diary/models/case.dart';
import 'package:lawyers_diary/models/date.dart';
import 'package:lawyers_diary/providers/case_provider.dart';
import 'package:lawyers_diary/providers/date_provider.dart';
import 'package:lawyers_diary/screens/caseDetailsScreen.dart';
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
  late CaseController _controller;
  List<List<String>> data = [];
  var titleColumn = [
    'Court Name',
    'Case No.',
    'Name of Party',
    'Particular',
    'Year',
    'Stage',
    'Next Date'
  ];
  var titleRow = [];

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

  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _controller = CaseController(ref: ref, context: context);
      log("didChangeDependencies is called");
      _controller.fetchAndSetAllCases();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  int disposeCases(List<Case> data) {
    return 0;
  }

  int unDatedCases(List<Case> data) {
    int i = 0;
    for (var item in data) {
      if (item.nextDate == null) {
        i++;
      }
    }
    return i;
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
    log('homepage build is called');
    var selectedDay = ref.watch(DateStateNotifierProvider).selectedDate;
    var loader = ref.watch(CaseStateNotifierProvider).isLoading;
    List<Case> caseforday = ref.watch(CaseStateNotifierProvider).fetchedByDate;
    List<Case> caseforMonth =
        ref.watch(CaseStateNotifierProvider).fetchedByMonth;
    log(caseforday.toString());
    titleRow = [];
    data = [];
    for (var case_ in caseforday) {
      titleRow.add(DateFormat.yMMMd().format(case_.previousDate!));
      List<String> d = [];
      d.add(case_.courtName);
      d.add(case_.caseNo);
      d.add(case_.party);
      d.add(case_.particular);
      d.add(case_.year);
      d.add(case_.stage);
      d.add(case_.nextDate == null
          ? ""
          : DateFormat.yMMMd().format(case_.nextDate!));
      data.add(d);
    }

    int expectedRows = caseforday.length;
    while (titleRow.length < expectedRows) {
      titleRow.add('');
    }
    while (data.length < expectedRows) {
      data.add(List<String>.filled(columns, ''));
    }
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
      body: (loader)
          ? const Center(
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: const CircularProgressIndicator()),
            )
          : Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      "Undated Cases : ${unDatedCases(caseforMonth).toString()}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: (caseforday.isEmpty)
                      ? const Center(
                          child: Text("No cases for the day"),
                        )
                      : Table(
                          border: TableBorder.all(),
                          columnWidths: const <int, TableColumnWidth>{
                            0: FlexColumnWidth(),
                            1: FlexColumnWidth(),
                            2: FlexColumnWidth(),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: <Widget>[
                                Container(
                                  color: Colors.grey,
                                  height: 50,
                                  child: const Center(
                                    child: Text(
                                      'Next Date',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                  height: 50,
                                  child: const Center(
                                    child: Text(
                                      'Case Number',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                  height: 50,
                                  child: const Center(
                                    child: Text(
                                      'Name of Party',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...caseforday.map((e) {
                              return TableRow(
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        e.nextDate == null
                                            ? ""
                                            : DateFormat.yMMMd()
                                                .format(e.nextDate!),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      ref
                                          .read(CaseStateNotifierProvider
                                              .notifier)
                                          .SelectedCaseUpdate(e);
                                      Navigator.of(context).pushNamed(
                                          Casedetailsscreen.routeName);
                                    },
                                    child: Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          e.caseNo.toString(),
                                          style: const TextStyle(
                                              color: Colors.blue),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      e.party,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                )
                // Center(
                //     child: StickyHeadersTable(
                //       columnsLength: columns,
                //       rowsLength: expectedRows,
                //       columnsTitleBuilder: (i) => Text(titleColumn[i]),
                //       rowsTitleBuilder: (i) => Text(titleRow[i]),
                //       contentCellBuilder: (j, i) =>
                //           Text(data[i][j].toString()),
                //       legendCell: const Text('Previous Date'),
                //     ),
                //   ),
              ],
            ),
    );
  }
}

class DialogBox extends ConsumerStatefulWidget {
  WidgetRef ref;
  DialogBox(this.ref);
  @override
  ConsumerState<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends ConsumerState<DialogBox> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = ref.read(DateStateNotifierProvider).selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    var dateCase = ref.watch(CaseStateNotifierProvider).dateCase;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(0),
        child: Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2075),
              availableGestures: AvailableGestures.all,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
                ref
                    .read(DateStateNotifierProvider.notifier)
                    .setDate(selectedDay);
                ref
                    .read(CaseStateNotifierProvider.notifier)
                    .fetchByDate(selectedDay);
                ref
                    .read(CaseStateNotifierProvider.notifier)
                    .fetchByMonth(selectedDay);
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarBuilders: CalendarBuilders(
                todayBuilder: (context, day, focusedDay) {
                  if (isSameDay(day, _focusedDay)) {
                    return Center(
                        child:
                            (dateCase[DateTime(day.year, day.month, day.day)] ==
                                    null)
                                ? CircleAvatar(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    child: Text(day.day.toString()),
                                  )
                                : Badge(
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    // largeSize: 20,
                                    label: (dateCase[DateTime(day.year,
                                                day.month, day.day)] ==
                                            null)
                                        ? SizedBox()
                                        : Text(dateCase[DateTime(
                                                day.year, day.month, day.day)]!
                                            .length
                                            .toString()),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      child: Text(day.day.toString()),
                                    ),
                                  ));
                  }
                  return Container(
                    margin: const EdgeInsets.all(5),
                    child: Center(
                      child:
                          (dateCase[DateTime(day.year, day.month, day.day)] ==
                                  null)
                              ? CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  child: Text(day.day.toString()),
                                )
                              : Badge(
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  // largeSize: 20,
                                  label: (dateCase[DateTime(
                                              day.year, day.month, day.day)] ==
                                          null)
                                      ? SizedBox()
                                      : Text(dateCase[DateTime(
                                              day.year, day.month, day.day)]!
                                          .length
                                          .toString()),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    child: Text(day.day.toString()),
                                  ),
                                ),
                    ),
                  );
                },
                defaultBuilder: (context, day, focusedDay) {
                  if (isSameDay(day, _focusedDay)) {
                    return Center(
                      child:
                          (dateCase[DateTime(day.year, day.month, day.day)] ==
                                  null)
                              ? CircleAvatar(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  child: Text(day.day.toString()),
                                )
                              : Badge(
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  // largeSize: 20,
                                  label: (dateCase[DateTime(
                                              day.year, day.month, day.day)] ==
                                          null)
                                      ? SizedBox()
                                      : Text(dateCase[DateTime(
                                              day.year, day.month, day.day)]!
                                          .length
                                          .toString()),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    child: Text(day.day.toString()),
                                  ),
                                ),
                    );
                  }
                  if (isSameDay(day, DateTime.now())) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      child: Center(
                        child:
                            (dateCase[DateTime(day.year, day.month, day.day)] ==
                                    null)
                                ? CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    child: Text(day.day.toString()),
                                  )
                                : Badge(
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    // largeSize: 20,
                                    label: (dateCase[DateTime(day.year,
                                                day.month, day.day)] ==
                                            null)
                                        ? SizedBox()
                                        : Text(dateCase[DateTime(
                                                day.year, day.month, day.day)]!
                                            .length
                                            .toString()),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      child: Text(day.day.toString()),
                                    ),
                                  ),
                      ),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.all(3),
                    child: Center(
                      child:
                          (dateCase[DateTime(day.year, day.month, day.day)] ==
                                  null)
                              ? CircleAvatar(
                                  child: Text(day.day.toString()),
                                )
                              : Badge(
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  // largeSize: 20,
                                  label: (dateCase[DateTime(
                                              day.year, day.month, day.day)] ==
                                          null)
                                      ? SizedBox()
                                      : Text(dateCase[DateTime(
                                              day.year, day.month, day.day)]!
                                          .length
                                          .toString()),
                                  child: CircleAvatar(
                                    child: Text(day.day.toString()),
                                  ),
                                ),
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
