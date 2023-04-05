// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fileio.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _passwordController = TextEditingController();
  bool passwordCorrect = false;
  List<File> files = [];

  @override
  void initState() {
    super.initState();
    // getFiles();
  }

  // Future<void> getFiles() async {
  //   final Directory dir = await FileIO.getPath(context);
  //   final List<FileSystemEntity> entities = dir.listSync();
  //   final List<File> fileList = entities
  //       .whereType<File>()
  //       .where((file) => file.path.endsWith('.json'))
  //       .toList();
  //   setState(() {
  //     files = fileList;
  //   });
  // }

  void checkPassword(String password) {
    if (password == 'admin') {
      setState(() {
        passwordCorrect = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Admin Page'),
      ),
      child: !passwordCorrect
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CupertinoTextField(
                        textInputAction: TextInputAction.done, // add this line
                        onSubmitted: (_) {
                          checkPassword(_passwordController.text);
                        },
                        controller: _passwordController,
                        placeholder: 'Password',
                        obscureText: true,
                      )),
                  const SizedBox(height: 16),
                ],
              ),
            )
          : ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                return CupertinoListTile(
                  title: Text(files[index].path.split('/').last),
                  trailing: const Icon(CupertinoIcons.forward),
                  onTap: () async {
                    final fileContent = await files[index].readAsString();
                    final dynamic jsonContent = jsonDecode(fileContent);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => FileViewPage(
                          fileName: files[index].path.split('/').last,
                          fileContent: jsonContent,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class FileViewPage extends StatelessWidget {
  const FileViewPage({
    Key? key,
    required this.fileName,
    required this.fileContent,
  }) : super(key: key);

  final String fileName;
  final dynamic fileContent;

  @override
  Widget build(BuildContext context) {
    final jsonString = const JsonEncoder.withIndent('  ').convert(fileContent);

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(fileName),
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Text(
                jsonString,
              ),
            ),
          ),
        ]));
  }
}
