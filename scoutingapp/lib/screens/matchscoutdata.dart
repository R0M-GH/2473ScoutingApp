import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class MatchData extends StatefulWidget {
  final String teamNumber, matchNumber, scoutName;

  const MatchData(
      {super.key,
      required this.scoutName,
      required this.teamNumber,
      required this.matchNumber});

  @override
  _MatchDataState createState() => _MatchDataState();
}

class _MatchDataState extends State<MatchData> {
  final GlobalKey imageKey = GlobalKey();

  // Auto fields
  bool _preloaded = false, exitCommunity = false;
  int autoChargeStation =
      0; // 0 ('Didn\'t Attempt'), 1 ('Failed Attempt'), 2 ('Docked'), 3 ('Engaged') // 'Didn\'t Attempt', 'Failed Attempt', 'Docked', 'Engaged'
  double autoRating = 0; // 0-10

  // Teleop fields
  bool groundPickup = false,
      singleSub = false,
      doubleSub = false,
      shuttleRobot = false,
      tippedConesPickup = false;
  double teleopRating = 0; // 0-10

  // Endgame fields
  int teleopChargeStation =
          0, // 0 ('Didn\'t Attempt'), 1 ('Failed Attempt'), 2 ('Docked'), 3 ('Engaged')
      numRobotsOnChargeStation = 0; // 0-3
  bool keeptScoring = false;

  // Final fields
  int allianceScore = 0,
      opponentScore = 0,
      numLinks = 0,
      avgCycleTime = 0, // user approximation in seconds
      result = 0; // -1 ('Loss'), 0 ('Tie'), 1 ('Win')
  bool coopertitionGrid = false, activationBonus = false;
  double defenseRating = 0; // 0-10

  final _specialCircumstancesController = TextEditingController(),
      _notesController = TextEditingController();

  Future<void> _saveData() async {
    final filename =
        '${widget.teamNumber}_${widget.matchNumber}_${widget.scoutName}.json';

    final data = {
      'Pre-loaded cargo:': _preloaded,
      'Exit community:': exitCommunity,
      'Auto charge station:': autoChargeStation,
      'Auto rating:': autoRating,
      'Ground pickup:': groundPickup,
      'Single sub:': singleSub,
      'Double sub:': doubleSub,
      'Shuttle robot:': shuttleRobot,
      'Tipped cones pickup:': tippedConesPickup,
      'Teleop rating:': teleopRating,
      'Teleop charge station:': teleopChargeStation,
      'Number of robots on charge station:': numRobotsOnChargeStation,
      'Keept scoring:': keeptScoring,
      'Alliance score:': allianceScore,
      'Opponent score:': opponentScore,
      'Number of links:': numLinks,
      'Average cycle time:': avgCycleTime,
      'Result:': result,
      'Coopertition grid:': coopertitionGrid,
      'Activation bonus:': activationBonus,
      'Defense rating:': defenseRating,
      'Special circumstances:': _specialCircumstancesController.text,
      'Notes:': _notesController.text,
    };

    final file = await _localFile(filename);
    await file.writeAsString(jsonEncode(data), mode: FileMode.append);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Match Scout"),
        ),
        child: Center());
  }
}
