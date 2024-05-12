import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CasesState with ChangeNotifier {
  List<Case> allCases;
  List<Case> fetchedByDate;
  Map<DateTime, List<Case>> dateCase;
  List<String> PrevDates;
  bool isLoading = false;
  CasesState(
      {this.PrevDates = const [],
      this.allCases = const [],
      this.fetchedByDate = const [],
      this.dateCase = const {},
      this.isLoading = false});

  CasesState copyWith(
      {List<Case>? allCases_,
      List<Case>? fetchedByDate_,
      List<String>? PrevDates_,
      Map<DateTime, List<Case>>? dateCase_,
      bool? isLoading_}) {
    return CasesState(
        PrevDates: PrevDates ?? [],
        allCases: allCases ?? [],
        fetchedByDate: fetchedByDate ?? [],
        dateCase: dateCase ?? {},
        isLoading: isLoading_ ?? false);
  }
}

class Case {
  String id;
  DateTime? previousDate;
  String courtName;
  String caseNo;
  String party;
  String year;
  String stage;
  DateTime? nextDate;
  String particular;
  DateTime? registrationDate;
  Case(
      {required this.id,
      required this.caseNo,
      required this.courtName,
      required this.party,
      required this.nextDate,
      required this.particular,
      required this.previousDate,
      required this.stage,
      required this.year,
      required this.registrationDate});
}
