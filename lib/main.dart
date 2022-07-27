import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/layouts/narrow.dart';
import 'package:timer/layouts/wide.dart';

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
      home: MyHomePage(title: title),
    );
  }

  ThemeData _buildTheme() {
    var baseTheme = ThemeData(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow));

    return baseTheme.copyWith(
      appBarTheme: baseTheme.appBarTheme.copyWith(
          elevation: 0,
          backgroundColor: baseTheme.scaffoldBackgroundColor,
          // foregroundColor: baseTheme.primaryColor,
          centerTitle: false),
      textTheme: GoogleFonts.robotoMonoTextTheme(baseTheme.textTheme).copyWith(
        displayLarge: GoogleFonts.nunitoSans(textStyle: baseTheme.textTheme.displayLarge),
          displayMedium: GoogleFonts.nunitoSans(textStyle: baseTheme.textTheme.displayMedium),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? timer;
  Duration secondsElapsed = const Duration(seconds: 0);

  void _start() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final seconds = secondsElapsed.inSeconds + 1;
      setState(() {
        secondsElapsed = Duration(seconds: seconds);
      });
    });
  }

  void _pause() {
    setState(() {
      timer!.cancel();
    });
  }

  void _reset() {
    _pause();
    setState(() {
      secondsElapsed = const Duration(seconds: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isTimerRunning = timer?.isActive ?? false;

    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > 500) {
        return WideLayout(
            title: widget.title,
            duration: secondsElapsed,
            pause: _pause,
            start: _start,
            reset: _reset,
            isPaused: !isTimerRunning);
      } else {
        return NarrowLayout(
            title: widget.title,
            duration: secondsElapsed,
            reset: _reset,
            start: _start,
            pause: _pause,
            isPaused: !isTimerRunning);
      }
    }));
  }
}
