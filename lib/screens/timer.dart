import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer/screens/list.dart';
import 'package:timer/widgets/display.dart';

class TimerPage extends StatefulWidget {
  const TimerPage(
      {Key? key,
      required this.title,
      required this.durations,
      required this.index})
      : super(key: key);
  final String title;
  final List<Duration> durations;
  final int index;

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
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
      timer?.cancel();
    });
  }

  void _reset() {
    _pause();
    setState(() {
      secondsElapsed = const Duration(seconds: 0);
    });
  }

  void _backToList() {
    _pause();
    final List<Duration> updatedDurations = widget.durations;
    updatedDurations[widget.index] = secondsElapsed;
    Navigator.of(context).pop(MaterialPageRoute(
        builder: (context) => ListPage(
              title: 'Enjoying Tiny Timer?',
              updatedDurations: updatedDurations,
            )));
  }

  @override
  void initState() {
    setState(() {
      secondsElapsed = widget.durations[widget.index];
    });
    _start();
    super.initState();
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
      appBar: AppBar(
        leading: BackButton(
          onPressed: _backToList,
        ),
        title: Text(widget.title),
      ),
      body: maxWidth > 500
          ? Column(
              children: [
                Expanded(
                    child: Display(
                  duration: secondsElapsed,
                )),
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
