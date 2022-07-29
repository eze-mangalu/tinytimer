import 'package:flutter/material.dart';

class NavBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const NavBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.timer_rounded, size: 20),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
