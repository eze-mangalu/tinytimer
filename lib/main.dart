import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer/layouts/narrow.dart';
import 'package:timer/layouts/wide.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        appBarTheme: AppBarTheme.of(context).copyWith(
            elevation: 0,
            backgroundColor: Colors.transparent,
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            centerTitle: false),
      ),
      home: const MyHomePage(title: 'Tiny Timer'),
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
