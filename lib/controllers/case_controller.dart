import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lawyers_diary/models/case.dart';
import 'package:lawyers_diary/providers/case_provider.dart';
import 'package:lawyers_diary/utils/alert_dialogue.dart';

class CaseController {
  WidgetRef ref;
  BuildContext context;
  CaseController({required this.ref, required this.context});

  Future<void> fetchAndSetAllCases() async {
    log("fetchAndSetallcases");
    try {
      ref.read(CaseStateNotifierProvider.notifier).setLoaderValue(true);
      List<Case> allCases = [];
      const endpoint =
          "https://lawyer-handbook-25bc2-default-rtdb.asia-southeast1.firebasedatabase.app/cases.json";
      final url = Uri.parse(endpoint);
      final response = await http.get(url);
      var resBody = jsonDecode(response.body);
      log(resBody.toString());
      for (var item in resBody.keys) {
        var id = item;
        log(id);
        var data = resBody[item];
        var dates = data['dates'];
        for (int i = 1; i < dates.length; i++) {
          allCases.add(Case(
            id: id,
            caseNo: data['caseNo'],
            courtName: data['courtName'],
            party: data['party'],
            nextDate: DateTime.parse(dates[i]),
            particular: data['particular'],
            previousDate: DateTime.parse(dates[i - 1]),
            stage: data['stage'],
            year: data['year'],
            registrationDate: DateTime.parse(dates[0]),
          ));
        }
        // Add the last case with nextDate as null
        allCases.add(Case(
          id: id,
          caseNo: data['caseNo'],
          courtName: data['courtName'],
          party: data['party'],
          nextDate: null,
          particular: data['particular'],
          previousDate: DateTime.parse(dates.last),
          stage: data['stage'],
          year: data['year'],
          registrationDate: DateTime.parse(dates[0]),
        ));
      }

      ref.read(CaseStateNotifierProvider.notifier).allCasesListUpdate(allCases);
      setDateCase();
      setMonthCase();

      ref.read(CaseStateNotifierProvider.notifier).setLoaderValue(false);
      // await showAlertDialogue(
      //     context: context,
      //     title: "Api Call Successfull",
      //     body: "Status Code : ${response.statusCode}");
    } catch (err) {
      log("Error caught is : ${err.toString()}");
      await showAlertDialogue(
          context: context,
          title: "Api Fail",
          body: "Error caught is : ${err.toString()}");

      ref.read(CaseStateNotifierProvider.notifier).setLoaderValue(false);
    }

    ref.read(CaseStateNotifierProvider.notifier).setLoaderValue(false);
  }

  void setDateCase() {
    Map<DateTime, List<Case>> dateCase = {};
    var allCases = ref.read(CaseStateNotifierProvider).allCases;
    for (var item in allCases) {
      if (!dateCase.containsKey(item.previousDate)) {
        dateCase[item.previousDate!] = [];
      }
      dateCase[item.previousDate]!.add(item);
    }
    ref.read(CaseStateNotifierProvider.notifier).dateCaseUpdate(dateCase);
  }

  void setMonthCase() {
    Map<String, List<Case>> monthCase = {};
    var allCases = ref.read(CaseStateNotifierProvider).allCases;
    for (var item in allCases) {
      String key = item.previousDate!.month.toString() +
          item.previousDate!.year.toString();
      if (!monthCase.containsKey(key)) {
        monthCase[key] = [];
      }
      monthCase[key]!.add(item);
    }
    ref.read(CaseStateNotifierProvider.notifier).monthCaseUpdate(monthCase);
  }

  Future<void> createNewCase(
      {required DateTime previousDate,
      required String courtName,
      required String caseNo,
      required String party,
      required String year,
      required String stage,
      required DateTime? nextDate,
      required DateTime registrationDate,
      required String particular}) async {
    ref.read(CaseStateNotifierProvider.notifier).setLoaderValue(true);
    var endpoint =
        "https://lawyer-handbook-25bc2-default-rtdb.asia-southeast1.firebasedatabase.app/cases.json";
    try {
      List<String> dates = [
        previousDate.toIso8601String(),
        // registrationDate.toIso8601String()
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
      var response = await http.post(url, body: jsonEncode(caseData), headers: {
        'accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      });
      var resData = jsonDecode(response.body);
      log(resData.toString());
      await fetchAndSetAllCases();
      ref.read(CaseStateNotifierProvider.notifier).setLoaderValue(false);
    } catch (err) {
      log(err.toString());
      ref.read(CaseStateNotifierProvider.notifier).setLoaderValue(false);
    }
  }

  Future<void> updateCase(
      {String? courtName,
      String? caseNo,
      String? party,
      String? year,
      String? stage,
      String? particular}) async {
    Case? selectedCase = ref.read(CaseStateNotifierProvider).SelectedCase;
    ref.read(CaseStateNotifierProvider.notifier).setLoaderValue(true);
    try {
      var endpoint =
          "https://lawyer-handbook-25bc2-default-rtdb.asia-southeast1.firebasedatabase.app/cases/${selectedCase!.id}.json";
      // var caseData = {
      //   'courtName': courtName ?? selectedCase.courtName,
      //   'caseNo': caseNo ?? selectedCase.caseNo,
      //   'party': party ?? selectedCase.party,
      //   'year': year ?? selectedCase.year,
      //   'stage': stage ?? selectedCase.stage,
      //   'particular': particular ?? selectedCase.particular
      // };
      var caseData = {};
      if (courtName != null && courtName != "")
        caseData['courtName'] = courtName;
      if (caseNo != null && caseNo != "") caseData['caseNo'] = caseNo;
      if (party != null && party != "") caseData['party'] = party;
      if (year != null && year != "") caseData['year'] = year;
      if (stage != null && stage != "") caseData['stage'] = stage;
      if (particular != null && particular != "")
        caseData['particular'] = particular;
      final url = Uri.parse(endpoint);
      var response = await http.patch(
        url,
        body: jsonEncode(caseData),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      var resData = jsonDecode(response.body);
      log(resData.toString());
      fetchAndSetAllCases();
      ref.read(CaseStateNotifierProvider.notifier).setLoaderValue(false);
    } catch (err) {
      log(err.toString());
      ref.read(CaseStateNotifierProvider.notifier).setLoaderValue(false);
    }
  }
}
