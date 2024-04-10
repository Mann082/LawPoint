import 'package:flutter/material.dart';

class DateData with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  void setDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  DateTime get selectedDate {
    return _selectedDate;
  }
}
