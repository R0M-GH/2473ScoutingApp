import 'package:flutter/cupertino.dart';

class MatchScout extends StatelessWidget {
  const MatchScout({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemTeal,
        navigationBar: CupertinoNavigationBar(
          middle: Text("Match Scout"),
        ),
        child: Center());
  }
}
