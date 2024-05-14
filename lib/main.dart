import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawyers_diary/models/case.dart';
import 'package:lawyers_diary/screens/HomePage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lawyers_diary/screens/newCase.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lawyers_diary/utils/logger.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(
      ProviderScope(observers: [Logger()], child: const LawyersDiary())));
}

class LawyersDiary extends StatelessWidget {
  const LawyersDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lawyer's Diary and HandBook",
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        NewCaseScreen.routeName: (context) => const NewCaseScreen()
      },
      initialRoute: HomePage.routeName,
      theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)),
    );
  }
}
