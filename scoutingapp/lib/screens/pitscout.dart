import 'package:flutter/cupertino.dart';

class PitScout extends StatelessWidget {
  const PitScout({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Pit Scout"),
        ),
        child: Center());
  }
}
