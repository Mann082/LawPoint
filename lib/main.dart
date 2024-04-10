import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawyers_diary/models/case.dart';
import 'package:lawyers_diary/models/date.dart';
import 'package:lawyers_diary/screens/HomePage.dart';
import 'package:lawyers_diary/screens/newCase.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const LawyersDiary()));
}

class LawyersDiary extends StatelessWidget {
  const LawyersDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Cases(),
          ),
          ChangeNotifierProvider(
            create: (context) => DateData(),
          )
        ],
        child: MaterialApp(
          title: "Lawyer's Diary and HandBook",
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            NewCaseScreen.routeName: (context) => const NewCaseScreen()
          },
          initialRoute: HomePage.routeName,
          theme: ThemeData(
              useMaterial3: true,
              textTheme:
                  GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)),
        ));
  }
}
