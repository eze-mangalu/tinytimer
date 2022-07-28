import 'dart:async';

import 'package:flutter/material.dart';

import '../layouts/narrow.dart';
import '../layouts/wide.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  void dispose() {
    timer?.cancel();
    super.dispose();
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
