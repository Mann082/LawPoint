import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lawyers_diary/models/case.dart';
import 'package:lawyers_diary/models/date.dart';

class DateNotifier extends StateNotifier<DateState> {
  DateNotifier() : super(DateState(selectedDate: DateTime.now()));
  DateState build() {
    return DateState(selectedDate: DateTime.now());
  }

  void setDate(DateTime newDate) {
    state = state.copyWith(newDate: newDate);
  }
}

final DateStateNotifierProvider =
    StateNotifierProvider<DateNotifier, DateState>((ref) => DateNotifier());
