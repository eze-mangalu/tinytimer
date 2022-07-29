import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final Duration duration;

  String timeDigits(int n) => n.toString().padLeft(2, '0');

  const Display({Key? key, required this.duration}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final hours = timeDigits(duration.inHours.remainder(24));
    final minutes = timeDigits(duration.inMinutes.remainder(60));
    final seconds = timeDigits(duration.inSeconds.remainder(60));

    final TextStyle? style = maxWidth > 800
        ? Theme.of(context).textTheme.displayLarge
        : Theme.of(context).textTheme.displayMedium;
    return Center(
      child: Text(
        '$hours:$minutes:$seconds',
        style: style,
      ),
    );
  }
}
