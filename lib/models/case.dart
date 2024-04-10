import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cases with ChangeNotifier {
  List<Case> _allCases = [];
  List<Case> _fetchedByDate = [];
  List<String> PrevDates = [];
  List<Case> get allCases {
    return [..._allCases];
  }

  void fetchAndSetAllCases() async {
    var copy = [..._allCases];
    _allCases = [];
    const endpoint =
        "https://lawyer-handbook-25bc2-default-rtdb.asia-southeast1.firebasedatabase.app.json";
    try {
      final url = Uri.parse(endpoint);
      final response = await http.get(url);
      final resBody = jsonDecode(response.body);
      print(resBody);
    } catch (err) {
      log(err.toString());
      _allCases = copy;
    }
    notifyListeners();
  }

  void findCaseByDate(DateTime date) async {}

  void createNewCase(
      {required DateTime previousDate,
      required String courtName,
      required String caseNo,
      required String party,
      required String year,
      required String stage,
      required DateTime? nextDate,
      required DateTime registrationDate,
      required String particular}) async {
    var endpoint =
        "https://lawyer-handbook-25bc2-default-rtdb.asia-southeast1.firebasedatabase/${registrationDate.toIso8601String()}.app.json";
    try {
      List<String> dates = [
        previousDate.toIso8601String(),
        registrationDate.toIso8601String()
      ];
      if (nextDate != null) {
        dates.add(nextDate.toIso8601String());
      }
      var caseData = {
        'courtName': courtName,
        'caseNo': caseNo,
        'party': party,
        'year': year,
        'stage': stage,
        'particular': particular,
        'dates': dates
      };
      final url = Uri.parse(endpoint);
      var response = await http.post(url, body: jsonEncode(caseData));
      print(jsonDecode(response.body));
    } catch (err) {
      log(err.toString());
    }
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
