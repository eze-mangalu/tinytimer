import 'package:flutter/material.dart';
import 'package:timer/widgets/Display.dart';

class WideLayout extends StatelessWidget {
  final String title;
  final Duration duration;
  final void Function() reset;
  final void Function() start;
  final void Function() pause;
  final bool isPaused;

  const WideLayout(
      {Key? key,
      required this.title,
      required this.duration,
      required this.pause,
      required this.start,
      required this.reset,
      required this.isPaused})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isStarted = duration.inMilliseconds > 0;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          Expanded(
            child: Display(
                duration: duration,
                style: Theme.of(context).textTheme.displayLarge),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: isStarted ? reset : null,
                  icon: const Icon(Icons.stop),
                ),
                const SizedBox(width: 100),
                isPaused
                    ? IconButton(
                        onPressed: start,
                        icon: const Icon(Icons.play_arrow_rounded))
                    : IconButton(
                        onPressed: pause,
                        icon: const Icon(Icons.pause_rounded)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
