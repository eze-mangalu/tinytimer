import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final Duration duration;
  final TextStyle? style;

  String timeDigits(int n) => n.toString().padLeft(2, '0');

  const Display({Key? key, required this.duration, this.style})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hours = timeDigits(duration.inHours.remainder(24));
    final minutes = timeDigits(duration.inMinutes.remainder(60));
    final seconds = timeDigits(duration.inSeconds.remainder(60));

    return Center(
      child: Text(
        '$hours:$minutes:$seconds',
        style: style ?? Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
