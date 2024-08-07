import 'package:flutter/material.dart';

class DateState with ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  DateState({
    required this.selectedDate,
  });
  DateState copyWith({DateTime? newDate, int? newdisposed, int? newunDated}) {
    return DateState(selectedDate: newDate ?? this.selectedDate);
  }
}
