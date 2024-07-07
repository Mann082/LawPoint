import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lawyers_diary/models/case.dart';
import 'package:lawyers_diary/providers/case_provider.dart';
import 'package:lawyers_diary/screens/editDetailsScreen.dart';

class Casedetailsscreen extends ConsumerStatefulWidget {
  static const routeName = "/CaseDetailScreen";
  const Casedetailsscreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CasedetailsscreenState();
}

class _CasedetailsscreenState extends ConsumerState<Casedetailsscreen> {
  @override
  Widget build(BuildContext context) {
    var selectedCase = ref.read(CaseStateNotifierProvider).SelectedCase;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('Case Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 50,
                color: Colors.black,
                child: const Center(
                  child: Text(
                    "Case Details",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth()
              },
              children: [
                TableRow(children: [
                  Container(
                      height: 50,
                      color: Colors.grey,
                      child: const Center(
                        child: Text("Case No."),
                      )),
                  Container(
                    child: Center(
                      child: Text("${selectedCase!.caseNo}"),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Container(
                      height: 50,
                      color: Colors.grey,
                      child: const Center(
                        child: Text("Court Name"),
                      )),
                  Container(
                    child: Center(
                      child: Text("${selectedCase!.courtName}"),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Container(
                      height: 50,
                      color: Colors.grey,
                      child: const Center(
                        child: Text("name of Party"),
                      )),
                  Container(
                    child: Center(
                      child: Text("${selectedCase!.party}"),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Container(
                      height: 50,
                      color: Colors.grey,
                      child: const Center(
                        child: Text("particular"),
                      )),
                  Container(
                    child: Center(
                      child: Text("${selectedCase!.particular}"),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Container(
                      height: 50,
                      color: Colors.grey,
                      child: const Center(
                        child: Text("Year"),
                      )),
                  Container(
                    child: Center(
                      child: Text("${selectedCase!.year}"),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Container(
                      height: 50,
                      color: Colors.grey,
                      child: const Center(
                        child: Text("Stage"),
                      )),
                  Container(
                    child: Center(
                      child: Text("${selectedCase!.stage}"),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Container(
                      height: 50,
                      color: Colors.grey,
                      child: const Center(
                        child: Text("Next Date"),
                      )),
                  Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        selectedCase.nextDate == null
                            ? ""
                            : DateFormat.yMMMd().format(selectedCase.nextDate!),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Container(
                      height: 50,
                      color: Colors.grey,
                      child: const Center(
                        child: Text("Previous Date"),
                      )),
                  Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        selectedCase.previousDate == null
                            ? ""
                            : DateFormat.yMMMd()
                                .format(selectedCase.previousDate!),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: MaterialButton(
                  color: Colors.blue,
                  elevation: 5,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(EditCaseScreen.routeName);
                  },
                  child: const Center(
                    child: Text("Edit Details"),
                  )),
            ),
            (selectedCase!.nextDate == null)
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: MaterialButton(
                        color: Colors.blue,
                        elevation: 5,
                        textColor: Colors.white,
                        onPressed: () {},
                        child: const Center(
                          child: Text("Add Next Date"),
                        )),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
