import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileIO {
  late final File file;
  late final Map<String, dynamic> jsonData;
  late final String filename;

  // static const String path = "C:/Users/rohan/Github/FRCScout/data";
  static late final String path;
  static const String scoutName = "scoutName",
      teamNumber = "teamNumber",
      matchNumber = "matchNumber",
      allianceColor = "allianceColor",
      allianceStation = "allianceStation",
      startingPosition = "startingPosition",
      preloaded = "preloaded",
      exitCommunity = "exitCommunity",
      autoChargeStation = "autoChargeStation",
      autoRating = "autoRating",
      groundPickup = "groundPickup",
      singlePickup = "singlePickup",
      doublePickup = "doublePickup",
      shuttleBot = "shuttleBot",
      tippedConesPickup = "tippedConesPickup",
      teleopRating = "teleopRating",
      teleopChargeStation = "teleopChargeStation",
      numBotsOnCharge = "numBotsOnCharge",
      keptScoring = "keptScoring",
      allianceScore = "allianceScore",
      opponentScore = "opponentScore",
      numLinks = "numLinks",
      cycleTime = "cycleTime",
      result = "result",
      coopertitionBonus = "coopertitionBonus",
      activationBonus = "activationBonus",
      defenseRating = "defenseRating",
      special = "special",
      notes = "notes",
      submitted = "submitted";

  FileIO(String teamNumber, String matchNumber, String scoutName) {
    getPath();
    final filename = '${teamNumber}_${matchNumber}_$scoutName.json';

    file = File('$path/$filename');
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      // set all default values
      jsonData = {
        scoutName: scoutName,
        teamNumber: teamNumber,
        matchNumber: matchNumber,
        allianceColor: "Red",
        allianceStation: 1,
        startingPosition: 1,
        preloaded: false,
        exitCommunity: false,
        autoChargeStation: "Didn't Attempt",
        groundPickup: false,
        singlePickup: false,
        doublePickup: false,
        shuttleBot: false,
        tippedConesPickup: false,
        numBotsOnCharge: 0,
        teleopChargeStation: "Didn't Attempt",
        keptScoring: false,
        result: "Win",
        allianceScore: 0,
        opponentScore: 0,
        numLinks: 0,
        cycleTime: 0,
        coopertitionBonus: false,
        activationBonus: false,
        autoRating: 5.0,
        teleopRating: 5.0,
        defenseRating: 5.0,
        special: "",
        notes: "",
        submitted: false
      };
      file.writeAsStringSync(
          const JsonEncoder.withIndent('  ').convert(jsonData));
    } else {
      jsonData = json.decode(file.readAsStringSync());
    }
  }

  void update(String field, dynamic newValue) {
    jsonData[field] = newValue;
    const encoder = JsonEncoder.withIndent('    ');
    file.writeAsStringSync(encoder.convert(jsonData));
  }

  dynamic get(String field) {
    return jsonData[field];
  }

  void submit() {
    update(submitted, true);
  }

  void getPath() async {
    path = (await getApplicationDocumentsDirectory()).path;
  }

  static bool fileExists(
      String teamNumber, String matchNumber, String scoutName) {
    final filename = '${teamNumber}_${matchNumber}_$scoutName.json';
    final file = File('$path/$filename');
    return file.existsSync();
  }
}
