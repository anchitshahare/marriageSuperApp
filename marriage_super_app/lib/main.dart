import 'package:flutter/material.dart';
import 'package:marriage_super_app/Expense_Tracker/screens/expense_tracker_screen.dart';
import 'package:marriage_super_app/screens/homepage_screen.dart';
import 'theme/color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mariage Super App',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: HomepageScreen(),
      routes: {
        ExpenseTrackerScreen.routeName: (context) => ExpenseTrackerScreen(),
        HomepageScreen.routeName: (context) => HomepageScreen(),
      },
    );
  }
}
