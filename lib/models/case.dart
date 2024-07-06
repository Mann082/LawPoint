import 'package:flutter/material.dart';

class CasesState with ChangeNotifier {
  List<Case> allCases;
  List<Case> fetchedByDate;
  List<Case> fetchedByMonth;
  Case? SelectedCase;
  Map<DateTime, List<Case>> dateCase;
  Map<String, List<Case>> monthCase;
  List<String> PrevDates;
  bool isLoading = false;
  CasesState(
      {this.PrevDates = const [],
      this.allCases = const [],
      this.fetchedByDate = const [],
      this.fetchedByMonth = const [],
      this.SelectedCase = null,
      this.dateCase = const {},
      this.monthCase = const {},
      this.isLoading = false});

  CasesState copyWith(
      {List<Case>? allCases_,
      List<Case>? fetchedByDate_,
      List<Case>? fetchedByMonth_,
      List<String>? PrevDates_,
      Case? selectedCase_,
      Map<DateTime, List<Case>>? dateCase_,
      Map<String, List<Case>>? monthCase_,
      bool? isLoading_}) {
    return CasesState(
        PrevDates: PrevDates_ ?? this.PrevDates,
        allCases: allCases_ ?? this.allCases,
        fetchedByDate: fetchedByDate_ ?? this.fetchedByDate,
        fetchedByMonth: fetchedByMonth_ ?? this.fetchedByMonth,
        SelectedCase: selectedCase_ ?? this.SelectedCase,
        dateCase: dateCase_ ?? this.dateCase,
        monthCase: monthCase_ ?? this.monthCase,
        isLoading: isLoading_ ?? this.isLoading);
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

  @override
  String toString() {
    return 'Case(id: $id, previousDate: $previousDate, courtName: $courtName, caseNo: $caseNo, party: $party, year: $year, stage: $stage, nextDate: $nextDate, particular: $particular, registrationDate: $registrationDate)';
  }
}
