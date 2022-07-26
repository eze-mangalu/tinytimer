import 'package:flutter/material.dart';
import 'package:timer/widgets/display.dart';

class NarrowLayout extends StatelessWidget {
  final String title;
  final Duration duration;
  final void Function() reset;
  final void Function() start;
  final void Function() pause;
  final bool isPaused;

  const NarrowLayout(
      {Key? key,
      required this.title,
      required this.duration,
      required this.reset,
      required this.start,
      required this.pause,
      required this.isPaused})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Display(duration: duration),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: IconButton(
                onPressed: (duration.inMilliseconds > 0) ? reset : null,
                icon: const Icon(Icons.stop),
              ),
            ),
          ],
        ),
        floatingActionButton: isPaused
            ? FloatingActionButton(
                onPressed: start,
                child: const Icon(Icons.play_arrow),
              )
            : FloatingActionButton(
                onPressed: pause,
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                child: const Icon(Icons.pause),
              ));
  }
}
