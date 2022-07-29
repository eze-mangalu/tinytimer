import 'package:flutter/material.dart';
import 'package:timer/screens/list.dart';

class NavBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const NavBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    const String listTitle = 'Timers';
    void _viewList() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ListPage()));
    }

    return AppBar(
      leading: Icon(Icons.timer_rounded, size: 20, color: Colors.yellow[700]),
      title: Text(title),
      actions: [
        maxWidth > 500
            ? TextButton(
                onPressed: _viewList,
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 20.0)),
                ),
                child: const Text(listTitle))
            : IconButton(
                tooltip: listTitle,
                onPressed: _viewList,
                icon: const Icon(Icons.timer_rounded))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
