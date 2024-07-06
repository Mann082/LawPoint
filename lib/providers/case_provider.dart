import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lawyers_diary/models/case.dart';

class CaseNotifier extends StateNotifier<CasesState> {
  CaseNotifier()
      : super(CasesState(
            PrevDates: [],
            allCases: [],
            dateCase: {},
            fetchedByDate: [],
            isLoading: false));
  CasesState build() {
    return CasesState();
  }

  void allCasesListUpdate(List<Case> newdata) {
    log(newdata.toString());
    state = state.copyWith(allCases_: newdata);
    log(state.allCases.toString());
  }

  void dateCaseUpdate(Map<DateTime, List<Case>> newData) {
    log(newData.toString());
    state = state.copyWith(dateCase_: newData);
  }

  void monthCaseUpdate(Map<String, List<Case>> newData) {
    log(newData.toString());
    state = state.copyWith(monthCase_: newData);
  }

  void SelectedCaseUpdate(Case newcase) {
    log("Selected CAse updated");
    state = state.copyWith(selectedCase_: newcase);
  }

  void fetchByDate(DateTime date) {
    DateTime newDate = DateTime(date.year, date.month, date.day);
    List<Case> data = state.dateCase[newDate] ?? [];
    state = state.copyWith(fetchedByDate_: data);
    log("fetched by date");
    log(data.toString());
  }

  void fetchByMonth(DateTime date) {
    String key = date.month.toString() + date.year.toString();
    List<Case> data = state.monthCase[key] ?? [];
    state = state.copyWith(fetchedByMonth_: data);
    log("Fetched by Month");
    log(data.toString());
  }

  void setLoaderValue(bool value) {
    log("its $value");
    state.isLoading = value;
  }
}

final CaseStateNotifierProvider =
    StateNotifierProvider<CaseNotifier, CasesState>((ref) => CaseNotifier());
