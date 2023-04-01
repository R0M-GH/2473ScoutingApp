// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoutingapp/screens/matchscoutdata.dart';

class MatchScout extends StatefulWidget {
  const MatchScout({Key? key}) : super(key: key);

  @override
  _MatchScoutState createState() => _MatchScoutState();
}

class _MatchScoutState extends State<MatchScout> {
  final GlobalKey imageKey = GlobalKey();

  String _allianceColor = 'Red'; // default value for alliance color
  int _allianceStation = 1; // default value for alliance station
  int _startingPosition = 1; // default value for starting position

  final _scoutNameController = TextEditingController();
  final _teamNumberController = TextEditingController();
  final _matchNumberController = TextEditingController();

  final _allianceColors = ['Red', 'Blue'];

  Future<void> _saveData() async {
    final filename =
        '${_teamNumberController.text}_${_matchNumberController.text}_${_scoutNameController.text}.json';

    final data = {
      'scoutName': _scoutNameController.text,
      'teamNumber': _teamNumberController.text,
      'matchNumber': _matchNumberController.text,
      'allianceColor': _allianceColor,
      'allianceStation': _allianceStation,
      'startingPosition': _startingPosition,
    };

    final file = await _localFile(filename);
    await file.writeAsString(jsonEncode(data));
  }

  Future<File> _localFile(String filename) async {
    // final path = await _localPath;
    const path = "C:\\Users\\rohan\\Github\\FRCScout\\data";

    return File('$path/$filename.txt');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  void dispose() {
    _scoutNameController.dispose();
    _teamNumberController.dispose();
    _matchNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Match Scout'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: CupertinoTextField(
                controller: _scoutNameController,
                placeholder: 'Scout Name',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Jockey One',
                  fontSize: 50,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: CupertinoTextField(
                    controller: _teamNumberController,
                    placeholder: 'Team #',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Jockey One',
                      fontSize: 40,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: CupertinoTextField(
                    controller: _matchNumberController,
                    placeholder: 'Match #',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Jockey One',
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoActionSheet(
                          title: const Text('Select Alliance Color'),
                          actions: List<Widget>.generate(_allianceColors.length,
                              (int index) {
                            return CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  _allianceColor = _allianceColors[index];
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                _allianceColors[index],
                                style: const TextStyle(fontSize: 24.0),
                              ),
                            );
                          }),
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$_allianceColor ▼",
                          style: const TextStyle(
                            fontFamily: 'Jockey One',
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoActionSheet(
                          title: const Text('Select Alliance Station'),
                          actions: List<Widget>.generate(3, (int index) {
                            return CupertinoActionSheetAction(
                              onPressed: () {
                                setState(() {
                                  _allianceStation = index + 1;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                (index + 1).toString(),
                                style: const TextStyle(fontSize: 24.0),
                              ),
                            );
                          }),
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$_allianceStation ▼",
                          style: const TextStyle(
                            fontFamily: 'Jockey One',
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Center(
                child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Image.asset('assets/images/field.png'),
            )),
            Center(
              child: GestureDetector(
                onTap: () {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoActionSheet(
                        title: const Text('Select Starting Position'),
                        actions: List<Widget>.generate(8, (int index) {
                          return CupertinoActionSheetAction(
                            onPressed: () {
                              setState(() {
                                _startingPosition = index + 1;
                              });
                              Navigator.pop(context);
                            },
                            child: Text(
                              (index + 1).toString(),
                              style: const TextStyle(fontSize: 24.0),
                            ),
                          );
                        }),
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$_startingPosition ▼',
                        style: const TextStyle(
                          fontFamily: 'Jockey One',
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: CupertinoButton(
                onPressed: () {
                  if (_scoutNameController.text.isNotEmpty &&
                      _teamNumberController.text.isNotEmpty &&
                      _matchNumberController.text.isNotEmpty) {
                    _saveData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MatchData(
                                teamNumber: _teamNumberController.text,
                                matchNumber: _matchNumberController.text,
                                scoutName: _scoutNameController.text,
                              )),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Missing Fields'),
                          content: const Text(
                              'Please fill out all required fields.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                color: Colors.black,
                child: const Text(
                  'New Report',
                  style: TextStyle(
                    fontFamily: 'Jockey One',
                    fontSize: 40,
                    color: Color(0xff93D500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
