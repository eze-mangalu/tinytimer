import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static String title = 'Tiny Timer';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: _buildTheme(),
      home: HomePage(title: title),
    );
  }

  ThemeData _buildTheme() {
    var baseTheme = ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow));

    return baseTheme.copyWith(
      appBarTheme: baseTheme.appBarTheme.copyWith(
          elevation: 0,
          backgroundColor: baseTheme.scaffoldBackgroundColor,
          // foregroundColor: baseTheme.primaryColor,
          centerTitle: false),
      textTheme: GoogleFonts.robotoMonoTextTheme(baseTheme.textTheme).copyWith(
        displayLarge:
            GoogleFonts.nunitoSans(textStyle: baseTheme.textTheme.displayLarge),
        displayMedium: GoogleFonts.nunitoSans(
            textStyle: baseTheme.textTheme.displayMedium),
      ),
    );
  }
}
