import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:lawyers_diary/models/case.dart';
import 'package:lawyers_diary/providers/case_provider.dart';

class CaseController {
  WidgetRef ref;
  CaseController({required this.ref});

  Future<void> fetchAndSetAllCases() async {
    log("fetchAndSetallcases");
    try {
      ref.watch(CaseStateNotifierProvider.notifier).setLoaderValue(true);
      List<Case> allCases = [];
      const endpoint =
          "https://lawyer-handbook-25bc2-default-rtdb.asia-southeast1.firebasedatabase.app/cases.json";
      final url = Uri.parse(endpoint);
      final response = await http.get(url);
      var resBody = jsonDecode(response.body);
      log(resBody.toString());
      for (var item in resBody.values) {
        var id = item['caseNo']; // Assuming caseNo is the ID
        var data = item;
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

      ref
          .watch(CaseStateNotifierProvider.notifier)
          .allCasesListUpdate(allCases);
      setDateCase();

      ref.watch(CaseStateNotifierProvider.notifier).setLoaderValue(false);
    } catch (err) {
      log("Error caught is : ${err.toString()}");

      ref.watch(CaseStateNotifierProvider.notifier).setLoaderValue(false);
    }

    ref.watch(CaseStateNotifierProvider.notifier).setLoaderValue(false);
  }

  void setDateCase() {
    Map<DateTime, List<Case>> dateCase = {};
    var allCases = ref.watch(CaseStateNotifierProvider).allCases;
    for (var item in allCases) {
      if (!dateCase.containsKey(item.previousDate)) {
        dateCase[item.previousDate!] = [];
      }
      dateCase[item.previousDate]!.add(item);
    }
    ref.watch(CaseStateNotifierProvider.notifier).dateCaseUpdate(dateCase);
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
    ref.watch(CaseStateNotifierProvider.notifier).setLoaderValue(true);
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
      setDateCase();
      ref.watch(CaseStateNotifierProvider.notifier).setLoaderValue(false);
    } catch (err) {
      log(err.toString());
      ref.watch(CaseStateNotifierProvider.notifier).setLoaderValue(false);
    }
  }
}
