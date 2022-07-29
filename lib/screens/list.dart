import 'package:flutter/material.dart';
import 'package:timer/screens/timer.dart';
import 'package:timer/widgets/display.dart';
import 'package:timer/widgets/nav_bar.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key, required this.title, this.updatedDurations})
      : super(key: key);
  final String title;
  final List<Duration>? updatedDurations;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Duration> durations = [];

  void addTimer() {
    setState(() {
      durations.add(const Duration(seconds: 0));
    });
  }

  void removeTimer(int index) {
    setState(() {
      durations.removeAt(index);
    });
  }

  startTimer(int index, Duration duration) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => TimerPage(
                  title: 'Timer',
                  durations: durations,
                  index: index,
                )))
        .then((value) => setState(() {
              widget.updatedDurations ?? durations;
            }));
  }

  @override
  Widget build(BuildContext context) {
    // final TextStyle? emptyTextStyle = Theme.of(context).textTheme.displayLarge;

    return Scaffold(
      appBar: NavBar(title: widget.title),
      body: durations.isNotEmpty
          ? _buildDurationList(durations)
          : const Center(
              child: Text('No timers found. Add one to get started.'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTimer,
        tooltip: 'Add timer',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  _buildDurationList(List<Duration> durations) {
    return ListView.builder(
      itemCount: durations.length,
      itemBuilder: (context, index) {
        final item = durations[index];
        return ListTile(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Display(
              duration: item,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () => startTimer(index, item),
                    icon: const Icon(Icons.play_arrow_rounded)),
                const SizedBox(
                  width: 30,
                ),
                IconButton(
                    onPressed: () => removeTimer(index),
                    icon: const Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                    )),
              ],
            )
          ],
        ));
      },
    );
  }
}
