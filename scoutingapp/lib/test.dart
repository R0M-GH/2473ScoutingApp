import 'package:flutter/cupertino.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemTeal,
        navigationBar: CupertinoNavigationBar(),
        child: Center());
  }
}
