import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lawyers_diary/controllers/case_controller.dart';
import 'package:lawyers_diary/models/case.dart';
import 'package:lawyers_diary/providers/case_provider.dart';

class NewCaseScreen extends ConsumerStatefulWidget {
  static const routeName = "/newCaseScreen";
  const NewCaseScreen({super.key});

  @override
  ConsumerState<NewCaseScreen> createState() => _NewCaseScreenState();
}

class _NewCaseScreenState extends ConsumerState<NewCaseScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  DateTime? registerDate;
  DateTime? previousDate;
  DateTime? nextDate;
  List<DropdownMenuItem<String>> nameOfCourt = const [
    DropdownMenuItem(value: 'Court 1', child: Text('Court 1')),
    DropdownMenuItem(value: 'Court 2', child: Text('Court 2')),
    DropdownMenuItem(value: 'Court 3', child: Text('Court 3')),
  ];
  var particular = const [
    DropdownMenuItem(value: 'Particular 1', child: Text('Particular 1')),
    DropdownMenuItem(value: 'Particular 2', child: Text('Particular 2')),
    DropdownMenuItem(value: 'Particular 3', child: Text('Particular 3')),
  ];
  var stage = const [
    DropdownMenuItem(value: 'Stage 1', child: Text('Stage 1')),
    DropdownMenuItem(value: 'Stage 2', child: Text('Stage 2')),
    DropdownMenuItem(value: 'Stage 3', child: Text('Stage 3')),
  ];
  var nameOfCourtController = TextEditingController();
  var caseNoController = TextEditingController();
  var nameOfPartyController = TextEditingController();
  var particularController = TextEditingController();
  var yearController = TextEditingController();
  var stageController = TextEditingController();

  openDatePicker() async {
    var result = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(),
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(15),
    );
    if (result == null || result.isEmpty) return null;
    return result[0];
  }

  @override
  void dispose() {
    nameOfCourtController.dispose();
    caseNoController.dispose();
    nameOfPartyController.dispose();
    particularController.dispose();
    yearController.dispose();
    stageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CaseController _controller = CaseController(ref: ref, context: context);
    var isLoading = ref.watch(CaseStateNotifierProvider).isLoading;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Case'),
        ),
        body: (isLoading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Register Case to Date'),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            registerDate = await openDatePicker();
                            setState(() {
                              log(registerDate.toString());
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                    style: BorderStyle.solid)),
                            child: Center(
                              child: Text(
                                (registerDate != null)
                                    ? DateFormat('d MMM yyyy')
                                        .format(registerDate!)
                                    : "",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          indent: 50,
                          endIndent: 50,
                          color: Colors.black,
                          height: 1,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Expanded(
                                  child: Text(
                                'Previous Date',
                                textAlign: TextAlign.center,
                              )),
                              SizedBox(
                                width: 180,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        previousDate = await openDatePicker();
                                        setState(() {
                                          log(previousDate.toString());
                                        });
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1,
                                                style: BorderStyle.solid)),
                                        child: Center(
                                          child: Text(
                                            (previousDate != null)
                                                ? DateFormat('d MMM yyyy')
                                                    .format(previousDate!)
                                                : "",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            previousDate = null;
                                          });
                                        },
                                        icon: const Icon(Icons.clear))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Expanded(
                                  child: Text(
                                'Name of Court',
                                textAlign: TextAlign.center,
                              )),
                              Column(
                                children: [
                                  Container(
                                    width: 180,
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid)),
                                    child: TextFormField(
                                      controller: nameOfCourtController,
                                      decoration: null,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 180.0,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid)),
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton<String>(
                                          value:
                                              null, // Set initial selection (optional)
                                          items: nameOfCourt,
                                          onChanged: (value) {
                                            setState(() {
                                              nameOfCourtController.value =
                                                  TextEditingValue(
                                                text: value ?? "",
                                                selection:
                                                    TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset: (value == null)
                                                          ? 0
                                                          : value.length),
                                                ),
                                              );
                                            });
                                          },
                                          hint: const Text('Select Court'),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Expanded(
                                  child: Text(
                                'Case No.',
                                textAlign: TextAlign.center,
                              )),
                              SizedBox(
                                width: 180,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 180,
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                              style: BorderStyle.solid)),
                                      child: TextFormField(
                                          controller: caseNoController),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Expanded(
                                  child: Text(
                                'Name of Party(v/s)',
                                textAlign: TextAlign.center,
                              )),
                              SizedBox(
                                width: 180,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 180,
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                              style: BorderStyle.solid)),
                                      child: TextFormField(
                                        controller: nameOfPartyController,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Expanded(
                                  child: Text(
                                'Particular',
                                textAlign: TextAlign.center,
                              )),
                              Column(
                                children: [
                                  Container(
                                    width: 180,
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid)),
                                    child: TextFormField(
                                      controller: particularController,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 180.0,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid)),
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton<String>(
                                          value:
                                              null, // Set initial selection (optional)
                                          items: particular,
                                          onChanged: (value) {
                                            setState(() {
                                              particularController.value =
                                                  TextEditingValue(
                                                text: value ?? "",
                                                selection:
                                                    TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset: (value == null)
                                                          ? 0
                                                          : value.length),
                                                ),
                                              );
                                            });
                                          },
                                          hint: const Text('Select Particular'),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Expanded(
                                  child: Text(
                                'Year',
                                textAlign: TextAlign.center,
                              )),
                              SizedBox(
                                width: 180,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 180,
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                              style: BorderStyle.solid)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: yearController,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Expanded(
                                  child: Text(
                                'Stage',
                                textAlign: TextAlign.center,
                              )),
                              Column(
                                children: [
                                  Container(
                                    width: 180,
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid)),
                                    child: TextFormField(
                                      controller: stageController,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 180.0,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid)),
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton<String>(
                                          value:
                                              null, // Set initial selection (optional)
                                          items: stage,
                                          onChanged: (value) {
                                            setState(() {
                                              stageController.value =
                                                  TextEditingValue(
                                                text: value ?? "",
                                                selection:
                                                    TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset: (value == null)
                                                          ? 0
                                                          : value.length),
                                                ),
                                              );
                                            });
                                          },
                                          hint: const Text('Select Stage'),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Expanded(
                                  child: Text(
                                'Next Date',
                                textAlign: TextAlign.center,
                              )),
                              SizedBox(
                                width: 180,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        nextDate = await openDatePicker();
                                        setState(() {
                                          log(nextDate.toString());
                                        });
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1,
                                                style: BorderStyle.solid)),
                                        child: Center(
                                          child: Text(
                                            (nextDate != null)
                                                ? DateFormat('d MMM yyyy')
                                                    .format(nextDate!)
                                                : "",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            nextDate = null;
                                          });
                                        },
                                        icon: const Icon(Icons.clear))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        SizedBox(
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.blue,
                                          style: BorderStyle.solid)),
                                  child: const Center(
                                    child: Text(
                                      'Cancel',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  bool isValid =
                                      _formKey.currentState!.validate();
                                  if (!isValid) {
                                    return;
                                  }
                                  _formKey.currentState!.save();
                                  var nameofCourt = nameOfCourtController.text;
                                  var caseNo = caseNoController.text;
                                  var nameOfParty = nameOfPartyController.text;
                                  var particular = particularController.text;
                                  var year = yearController.text;
                                  var stage = stageController.text;
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await _controller.createNewCase(
                                      previousDate:
                                          previousDate ?? DateTime(1000),
                                      courtName: nameofCourt,
                                      caseNo: caseNo,
                                      party: nameOfParty,
                                      year: year,
                                      stage: stage,
                                      nextDate: nextDate,
                                      registrationDate:
                                          registerDate ?? DateTime(1000),
                                      particular: particular);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.blue,
                                          style: BorderStyle.solid),
                                      color: Colors.blue),
                                  child: const Center(
                                    child: Text(
                                      'Save',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )));
  }
}
