import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/display.dart';
import '../widgets/nav_bar.dart';

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
    final double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: NavBar(
        title: widget.title,
      ),
      body: maxWidth > 500
          ? Column(
              children: [
                Expanded(
                  child: Display(
                      duration: secondsElapsed,
                      style: Theme.of(context).textTheme.displayLarge),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed:
                            secondsElapsed.inMilliseconds > 0 ? _reset : null,
                        icon: const Icon(Icons.stop),
                      ),
                      const SizedBox(width: 100),
                      !isTimerRunning
                          ? IconButton(
                              onPressed: _start,
                              icon: const Icon(Icons.play_arrow_rounded))
                          : IconButton(
                              onPressed: _pause,
                              icon: const Icon(Icons.pause_rounded)),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Display(duration: secondsElapsed),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: IconButton(
                    onPressed:
                        (secondsElapsed.inMilliseconds > 0) ? _reset : null,
                    icon: const Icon(Icons.stop),
                  ),
                ),
              ],
            ),
      floatingActionButton: (maxWidth > 500)
          ? null
          : (!isTimerRunning
              ? FloatingActionButton(
                  onPressed: _start,
                  child: const Icon(Icons.play_arrow_rounded),
                )
              : FloatingActionButton(
                  onPressed: _pause,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.pause_rounded),
                )),
    );
  }
}
