import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'matchscout.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    double h1 =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    double w1 =
        MediaQuery.of(context).size.width - padding.left - padding.right;

    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemTeal,
        navigationBar: const CupertinoNavigationBar(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // SizedBox(height: (h1 / 48)),
              const Center(
                child: Text(
                  'Main Menu',
                  style: TextStyle(
                      fontFamily: 'Jockey One',
                      fontSize: 80,
                      color: Colors.black),
                ),
              ),
              Center(
                  child: CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MenuPage()),
                  );
                },
                color: Colors.black,
                child: const Text(
                  'Match Scout',
                  style: TextStyle(
                      fontFamily: 'Jockey One',
                      fontSize: 40,
                      color: Color(0xff93D500)),
                ),
              )),
              Center(
                  child: CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MenuPage()),
                  );
                },
                color: Colors.black,
                child: const Text(
                  'Pit Scout',
                  style: TextStyle(
                      fontFamily: 'Jockey One',
                      fontSize: 40,
                      color: Color(0xff93D500)),
                ),
              )),
              Center(
                  child: CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MenuPage()),
                  );
                },
                color: Colors.black,
                child: const Text(
                  'Admin',
                  style: TextStyle(
                      fontFamily: 'Jockey One',
                      fontSize: 40,
                      color: Color.fromARGB(255, 255, 68, 68)),
                ),
              )),
            ],
          ),
        ));
  }
}
