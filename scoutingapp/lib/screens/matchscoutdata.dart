// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoutingapp/screens/homepage.dart';

import '../fileio.dart';

class MatchData extends StatefulWidget {
  final FileIO file;

  const MatchData({Key? key, required this.file}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _MatchDataState createState() => _MatchDataState(file: file);
}

class _MatchDataState extends State<MatchData> {
  final GlobalKey imageKey = GlobalKey();
  late final FileIO file;
  final chargeStation = ['Engaged', 'Docked', 'Failed', 'Didn\'t Attempt'];
  final outcomes = ['Win', 'Loss', 'Tie'];

  final _allianceScoreController = TextEditingController();
  final _opponentScoreController = TextEditingController();
  final _numLinksController = TextEditingController();
  final _cycleTimeController = TextEditingController();
  final _notesController = TextEditingController();
  final _specialController = TextEditingController();

  _MatchDataState({required this.file});

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    super.dispose();
    _allianceScoreController.dispose();
    _opponentScoreController.dispose();
    _numLinksController.dispose();
    _cycleTimeController.dispose();
    _notesController.dispose();
    _specialController.dispose();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        // ignore: prefer_const_constructors
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Match Scout'),
        ),
        child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Expanded(
                  child: CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  // ignore: prefer_const_literals_to_create_immutables
                  items: <BottomNavigationBarItem>[
                    const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.antenna_radiowaves_left_right),
                      label: 'Autonomous',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.game_controller_solid),
                      label: 'Teleop',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.flag_circle_fill),
                      label: 'Endgame',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.car_detailed),
                      label: 'Post-Game',
                    ),
                  ],
                ),
                tabBuilder: (BuildContext context, int index) {
                  return CupertinoTabView(
                    builder: (BuildContext context) {
                      if (index == 0) {
                        return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: CupertinoFormRow(
                                      prefix: CupertinoSwitch(
                                        value: file.get(FileIO.preloaded),
                                        onChanged: (bool value) {
                                          setState(() {
                                            file.update(
                                                FileIO.preloaded, value);
                                          });
                                        },
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Pre-Loaded Cargo?',
                                          style: TextStyle(
                                              fontFamily: 'Jockey One',
                                              fontSize: 30,
                                              color: Colors.black),
                                        ),
                                      ),
                                    )),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: CupertinoFormRow(
                                    prefix: CupertinoSwitch(
                                      value: file.get(FileIO.exitCommunity),
                                      onChanged: (bool value) {
                                        setState(() {
                                          file.update(
                                              FileIO.exitCommunity, value);
                                        });
                                      },
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Exit Community?',
                                        style: TextStyle(
                                            fontFamily: 'Jockey One',
                                            fontSize: 30,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoActionSheet(
                                          title: const Text(
                                              'Select Charging Station Configuration'),
                                          actions: List<Widget>.generate(
                                              chargeStation.length,
                                              (int index) {
                                            return CupertinoActionSheetAction(
                                              onPressed: () {
                                                setState(() {
                                                  file.update(
                                                      FileIO.autoChargeStation,
                                                      chargeStation[index]);
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                chargeStation[index],
                                                style: const TextStyle(
                                                    fontSize: 24.0),
                                              ),
                                            );
                                          }),
                                          cancelButton:
                                              CupertinoActionSheetAction(
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${file.get(FileIO.autoChargeStation)} ▼',
                                          style: const TextStyle(
                                            fontFamily: 'Jockey One',
                                            fontSize: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                              ]),
                        );
                      } else if (index == 1) {
                        return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(children: [
                                      const Text(
                                        'Pickup Locations',
                                        style: TextStyle(
                                          fontFamily: 'Jockey One',
                                          fontSize: 40,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      CupertinoFormRow(
                                        prefix: CupertinoSwitch(
                                          value: file.get(FileIO.groundPickup),
                                          onChanged: (bool value) {
                                            setState(() {
                                              file.update(
                                                  FileIO.groundPickup, value);
                                            });
                                          },
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Ground Pickup',
                                            style: TextStyle(
                                                fontFamily: 'Jockey One',
                                                fontSize: 35,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      CupertinoFormRow(
                                        prefix: CupertinoSwitch(
                                          value: file.get(FileIO.singlePickup),
                                          onChanged: (bool value) {
                                            setState(() {
                                              file.update(
                                                  FileIO.singlePickup, value);
                                            });
                                          },
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Single Substation',
                                            style: TextStyle(
                                                fontFamily: 'Jockey One',
                                                fontSize: 35,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      CupertinoFormRow(
                                        prefix: CupertinoSwitch(
                                          value: file.get(FileIO.doublePickup),
                                          onChanged: (bool value) {
                                            setState(() {
                                              file.update(
                                                  FileIO.doublePickup, value);
                                            });
                                          },
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Double Substation',
                                            style: TextStyle(
                                                fontFamily: 'Jockey One',
                                                fontSize: 35,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ])),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: CupertinoFormRow(
                                      prefix: CupertinoSwitch(
                                        value: file.get(FileIO.shuttleBot),
                                        onChanged: (bool value) {
                                          setState(() {
                                            file.update(
                                                FileIO.shuttleBot, value);
                                          });
                                        },
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Shuttle Robot?',
                                          style: TextStyle(
                                              fontFamily: 'Jockey One',
                                              fontSize: 35,
                                              color: Colors.black),
                                        ),
                                      ),
                                    )),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: CupertinoFormRow(
                                      prefix: CupertinoSwitch(
                                        value:
                                            file.get(FileIO.tippedConesPickup),
                                        onChanged: (bool value) {
                                          setState(() {
                                            file.update(
                                                FileIO.tippedConesPickup,
                                                value);
                                          });
                                        },
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Pickup Tipped Cones?',
                                          style: TextStyle(
                                              fontFamily: 'Jockey One',
                                              fontSize: 35,
                                              color: Colors.black),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                              ]),
                        );
                      } else if (index == 2) {
                        return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoActionSheet(
                                          title: const Text(
                                              '# Bots on Charge Station'),
                                          actions: List<Widget>.generate(4,
                                              (int index) {
                                            return CupertinoActionSheetAction(
                                              onPressed: () {
                                                setState(() {
                                                  file.update(
                                                      FileIO.numBotsOnCharge,
                                                      index);
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                (index).toString(),
                                                style: const TextStyle(
                                                    fontSize: 24.0),
                                              ),
                                            );
                                          }),
                                          cancelButton:
                                              CupertinoActionSheetAction(
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${file.get(FileIO.numBotsOnCharge)} Bots on Station ▼",
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
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
                                          title: const Text(
                                              'Select Charging Station Configuration'),
                                          actions: List<Widget>.generate(
                                              chargeStation.length,
                                              (int index) {
                                            return CupertinoActionSheetAction(
                                              onPressed: () {
                                                setState(() {
                                                  file.update(
                                                      FileIO
                                                          .teleopChargeStation,
                                                      chargeStation[index]);
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                chargeStation[index],
                                                style: const TextStyle(
                                                    fontSize: 24.0),
                                              ),
                                            );
                                          }),
                                          cancelButton:
                                              CupertinoActionSheetAction(
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${file.get(FileIO.teleopChargeStation)} ▼',
                                          style: const TextStyle(
                                            fontFamily: 'Jockey One',
                                            fontSize: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: CupertinoFormRow(
                                    prefix: CupertinoSwitch(
                                      value: file.get(FileIO.keptScoring),
                                      onChanged: (bool value) {
                                        setState(() {
                                          file.update(
                                              FileIO.keptScoring, value);
                                        });
                                      },
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Kept Scoring?',
                                        style: TextStyle(
                                            fontFamily: 'Jockey One',
                                            fontSize: 35,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoActionSheet(
                                          title: const Text(
                                              'What was the outcome of the match?'),
                                          actions: List<Widget>.generate(
                                              outcomes.length, (int index) {
                                            return CupertinoActionSheetAction(
                                              onPressed: () {
                                                setState(() {
                                                  file.update(FileIO.result,
                                                      outcomes[index]);
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                outcomes[index],
                                                style: const TextStyle(
                                                    fontSize: 24.0),
                                              ),
                                            );
                                          }),
                                          cancelButton:
                                              CupertinoActionSheetAction(
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${file.get(FileIO.result)} ▼',
                                          style: const TextStyle(
                                            fontFamily: 'Jockey One',
                                            fontSize: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.425,
                                      child: CupertinoTextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        controller: _allianceScoreController,
                                        placeholder: 'Alliance Score',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: 'Jockey One',
                                          fontSize: 30,
                                        ),
                                        onChanged: (String value) {
                                          setState(() {
                                            file.update(FileIO.allianceScore,
                                                int.parse(value));
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.425,
                                      child: CupertinoTextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        controller: _opponentScoreController,
                                        placeholder: 'Opponent Score',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: 'Jockey One',
                                          fontSize: 30,
                                        ),
                                        onChanged: (String value) {
                                          setState(() {
                                            file.update(FileIO.opponentScore,
                                                int.parse(value));
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.425,
                                      child: CupertinoTextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        controller: _numLinksController,
                                        placeholder: '# Links',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: 'Jockey One',
                                          fontSize: 30,
                                        ),
                                        onChanged: (String value) {
                                          setState(() {
                                            file.update(FileIO.numLinks,
                                                int.parse(value));
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.425,
                                      child: CupertinoTextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        controller: _cycleTimeController,
                                        placeholder: 'Cycle Time (s)',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: 'Jockey One',
                                          fontSize: 30,
                                        ),
                                        onChanged: (String value) {
                                          setState(() {
                                            file.update(FileIO.cycleTime,
                                                int.parse(value));
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: CupertinoFormRow(
                                    prefix: CupertinoSwitch(
                                      value: file.get(FileIO.coopertitionBonus),
                                      onChanged: (bool value) {
                                        setState(() {
                                          file.update(
                                              FileIO.coopertitionBonus, value);
                                        });
                                      },
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Coopertition Bonus?',
                                        style: TextStyle(
                                            fontFamily: 'Jockey One',
                                            fontSize: 35,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: CupertinoFormRow(
                                    prefix: CupertinoSwitch(
                                      value: file.get(FileIO.activationBonus),
                                      onChanged: (bool value) {
                                        setState(() {
                                          file.update(
                                              FileIO.activationBonus, value);
                                        });
                                      },
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Activation Bonus?',
                                        style: TextStyle(
                                            fontFamily: 'Jockey One',
                                            fontSize: 35,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                              ]),
                        );
                      } else if (index == 3) {
                        return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(children: [
                                      Text(
                                        'Auto Rating: ${file.get(FileIO.autoRating).toInt()}',
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                          fontFamily: 'Jockey One',
                                          fontSize: 30,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      CupertinoSlider(
                                        value: file
                                            .get(FileIO.autoRating)
                                            .toDouble(),
                                        divisions: 10,
                                        max: 10.0,
                                        min: 0.0,
                                        onChanged: (double value) {
                                          setState(() {
                                            file.update(
                                                FileIO.autoRating, value);
                                          });
                                        },
                                      ),
                                    ])),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(children: [
                                      Text(
                                        'Teleop Rating: ${file.get(FileIO.teleopRating).toInt()}',
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                          fontFamily: 'Jockey One',
                                          fontSize: 30,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      CupertinoSlider(
                                        value: file
                                            .get(FileIO.teleopRating)
                                            .toDouble(),
                                        divisions: 10,
                                        max: 10.0,
                                        min: 0.0,
                                        onChanged: (double value) {
                                          setState(() {
                                            file.update(
                                                FileIO.teleopRating, value);
                                          });
                                        },
                                      ),
                                    ])),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(children: [
                                      Text(
                                        'Defense Rating: ${file.get(FileIO.defenseRating).toInt()}',
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                          fontFamily: 'Jockey One',
                                          fontSize: 30,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      CupertinoSlider(
                                        value: file
                                            .get(FileIO.defenseRating)
                                            .toDouble(),
                                        divisions: 10,
                                        max: 10.0,
                                        min: 0.0,
                                        onChanged: (double value) {
                                          setState(() {
                                            file.update(
                                                FileIO.defenseRating, value);
                                          });
                                        },
                                      ),
                                    ])),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(children: [
                                      // ignore: prefer_const_constructors
                                      Text(
                                        'Special Circumstances',
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                          fontFamily: 'Jockey One',
                                          fontSize: 30,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.88,
                                        child: CupertinoTextField(
                                          controller: _specialController,
                                          placeholder:
                                              'i.e. robot disabled, broken, tipped over, etc...',
                                          onChanged: (String value) {
                                            setState(() {
                                              file.update(
                                                  FileIO.special, value);
                                            });
                                          },
                                          maxLines: null,
                                        ),
                                      )
                                    ])),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(children: [
                                      // ignore: prefer_const_constructors
                                      Text(
                                        'Notes',
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                          fontFamily: 'Jockey One',
                                          fontSize: 30,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.88,
                                        child: CupertinoTextField(
                                          controller: _notesController,
                                          placeholder:
                                              'i.e. great drivers, crazy mechs, etc...',
                                          onChanged: (String value) {
                                            setState(() {
                                              file.update(FileIO.notes, value);
                                            });
                                          },
                                          maxLines: null,
                                        ),
                                      )
                                    ])),
                                CupertinoButton(
                                  onPressed: () {
                                    file.submit();
                                    dispose();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()),
                                    );
                                  },
                                  color: Colors.black,
                                  child: const Text(
                                    'Submit Report',
                                    style: TextStyle(
                                      fontFamily: 'Jockey One',
                                      fontSize: 40,
                                      color: Color(0xff93D500),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                              ]),
                        );
                      }
                      return const Center(
                        child: Text('ERROR'),
                      );
                    },
                  );
                },
              ))
            ])));
  }
}
