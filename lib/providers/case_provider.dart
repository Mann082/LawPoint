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

  void setLoaderValue(bool value) {
    log("its $value");
    state.isLoading = value;
  }

  // void selectedEmployeeIndex(int value) {
  //   state.selectedEmployeeIndex = value;
  //   log("Selected Index: $value");
  // }
}

final CaseStateNotifierProvider =
    StateNotifierProvider<CaseNotifier, CasesState>((ref) => CaseNotifier());
