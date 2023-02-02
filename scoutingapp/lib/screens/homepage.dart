import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menupage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemTeal,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50.0),
              const Center(
                child: Text(
                  'FRCScout',
                  style: TextStyle(
                      fontFamily: 'Jockey One',
                      fontSize: 80,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: Image.asset(
                  'assets/images/chargedup.png',
                  width: 300,
                ),
              ),
              const SizedBox(height: 32.0),
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
                  'ENERGIZE',
                  style: TextStyle(
                      fontFamily: 'Jockey One',
                      fontSize: 40,
                      color: Color(0xff93D500)),
                ),
              )),
              const SizedBox(height: 80.0),
              const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Dev: R0M-GH\nVersion: Beta V 2023.0.0.1',
                    style: TextStyle(
                        fontFamily: 'Jockey One',
                        fontSize: 20,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ));
  }
}
