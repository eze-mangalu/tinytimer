import 'dart:async';

import 'package:flutter/material.dart';

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

  void _startCounter() {
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
    final TextStyle? style = Theme.of(context).textTheme.displayMedium;
    String timeDigits(int n) => n.toString().padLeft(2, '0');

    final hours = timeDigits(secondsElapsed.inHours.remainder(24));
    final minutes = timeDigits(secondsElapsed.inMinutes.remainder(60));
    final seconds = timeDigits(secondsElapsed.inSeconds.remainder(60));

    final bool isTimerRunning = timer?.isActive ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                '$hours:$minutes:$seconds',
                style: style,
              ),
            ),
          ),
          if (secondsElapsed.inMilliseconds > 0)
            IconButton(
              onPressed: _reset,
              icon: const Icon(Icons.stop),
            ),
        ],
      ),
      floatingActionButton: !isTimerRunning
          ? FloatingActionButton(
              onPressed: _startCounter,
              child: const Icon(Icons.play_arrow),
            )
          : FloatingActionButton(
              onPressed: _pause,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              child: const Icon(Icons.pause),
            ),
    );
  }
}
