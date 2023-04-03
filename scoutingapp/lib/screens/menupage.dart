import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoutingapp/screens/admin.dart';
import 'package:scoutingapp/screens/pitscout.dart';

import 'matchscout.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Main Menu'),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Center(
                  child: CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MatchScout()),
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
                    MaterialPageRoute(builder: (context) => const PitScout()),
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
                    MaterialPageRoute(builder: (context) => const AdminPage()),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ));
  }
}
