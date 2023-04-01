import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class NodeGrid extends StatefulWidget {
  final String teamNumber, matchNumber, scoutName;

  const NodeGrid(
      {super.key,
      required this.teamNumber,
      required this.matchNumber,
      required this.scoutName});

  @override
  _NodeGridState createState() => _NodeGridState();
}

class _NodeGridState extends State<NodeGrid> {
  final List<bool> _nodeScores =
      List.filled(9, false); // keep track of which nodes are scored

  Future<void> _saveData() async {
    final filename =
        '${widget.teamNumber}_${widget.matchNumber}_${widget.scoutName}_node_data.json';

    final data = {
      'nodeScores': _nodeScores,
    };

    final file = await _localFile(filename);
    await file.writeAsString(jsonEncode(data));
  }

  Future<File> _localFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _nodeScores[index] =
                  !_nodeScores[index]; // toggle the score state
              _saveData(); // save the updated score data
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: _nodeScores[index]
                    ? Colors.green
                    : Colors.grey, // use green border for scored nodes
                width: 2.0,
              ),
            ),
            child: Center(
              child: Text(
                'Node ${index + 1}',
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        );
      },
      itemCount: 9,
    );
  }
}
