import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoutingapp/screens/pitscout.dart';

import 'homepage.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemTeal,
      navigationBar: CupertinoNavigationBar(middle: Text('Main Menu')),
      child: Center(),
    );
  }
}
