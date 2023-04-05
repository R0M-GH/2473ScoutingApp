import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menupage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const Center(
            child: Text(
              'FRCScout',
              style: TextStyle(
                  fontFamily: 'Jockey One', fontSize: 80, color: Colors.black),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/chargedup.png',
              width: 250,
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
              'ENERGIZE',
              style: TextStyle(
                  fontFamily: 'Jockey One',
                  fontSize: 40,
                  color: Color(0xff93D500)),
            ),
          )),
          const Center(
              child: Text(
            'Dev: R0M-GH\nVersion: Beta V 2023.0.3',
            style: TextStyle(
                fontFamily: 'Jockey One', fontSize: 20, color: Colors.black),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    ));
  }
}
