// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoutingapp/screens/matchscoutdata.dart';

import '../fileio.dart';

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
      resizeToAvoidBottomInset: false,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Match Scout'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
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
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
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
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
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
                        actions: List<Widget>.generate(6, (int index) {
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
                    FileIO file = FileIO(_teamNumberController.text,
                        _matchNumberController.text, _scoutNameController.text);
                    file.update(FileIO.startingPosition, _startingPosition);
                    file.update(FileIO.allianceColor, _allianceColor);
                    file.update(FileIO.allianceStation, _allianceStation);
                    dispose();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MatchData(
                                file: file,
                              )),
                    );
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: const Text('Missing Fields'),
                        content:
                            const Text('Please fill out all required fields.'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
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
