import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DataModel {
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/todo.json");
  }

  void saveData(Map<String, List> map) async {
    String data = json.encode(map);

    final file = await _getFile();
    file.writeAsString(data);
  }

  void saveTodoData(Map<String, dynamic> item) async {
    final data = await readData();

    await data['todo'].add(item);

    saveData(data);
  }

  void saveDoneData(Map<String, dynamic> item) async {
    final data = await readData();

    await data["done"].add(item);

    saveData(data);
  }

  void saveTrashData(Map item) async {
    final data = await readData();

    await data["trash"].add(item);

    saveData(data);
  }

  Future<Map> readData() async {
    try {
      final file = await _getFile();

      String data = await file.readAsStringSync();

      return json.decode(data);
    } catch (e) {
      return null;
    }
  }

  Map createInitialJsonData() {
    Map<String, List> initData = Map();
    initData['todo'] = [];
    initData['done'] = [];
    initData['trash'] = [];

    saveData(initData);

    return initData;
  }
}
