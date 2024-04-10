import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class NewCaseScreen extends StatefulWidget {
  static const routeName = "/newCaseScreen";
  const NewCaseScreen({super.key});

  @override
  State<NewCaseScreen> createState() => _NewCaseScreenState();
}

class _NewCaseScreenState extends State<NewCaseScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  DateTime? registerDate;
  DateTime? previousDate;
  DateTime? nextDate;

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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Case'),
        ),
        body: Form(
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
                        child: Text(
                          DateFormat.yMd()
                              .format(registerDate ?? DateTime(2019)),
                          textAlign: TextAlign.center,
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
                                Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                          style: BorderStyle.solid)),
                                ),
                                IconButton(
                                    onPressed: () {},
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
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: TextFormField(),
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
                                    child: DropdownButton(
                                      items: [],
                                      onChanged: (value) {},
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
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
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                          style: BorderStyle.solid)),
                                  child: TextFormField(),
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
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                          style: BorderStyle.solid)),
                                  child: TextFormField(),
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
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: TextFormField(),
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
                                    child: DropdownButton(
                                      items: [],
                                      onChanged: (value) {},
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
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
                                  child: TextFormField(),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                          style: BorderStyle.solid)),
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
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        style: BorderStyle.solid)),
                                child: TextFormField(),
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
                                    child: DropdownButton(
                                      items: [],
                                      onChanged: (value) {},
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
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
                                Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                          style: BorderStyle.solid)),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.clear))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
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
                              ),
                            ),
                          ),
                          Container(
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
