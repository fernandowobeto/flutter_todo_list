import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ToDoModel {
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/todo.json");
  }

  void saveData(List lista) async {
    String data = json.encode(lista);

    final file = await _getFile();
    file.writeAsString(data);
  }

  void addData(Map map){
    readData().then((list) {
      if(list == null){
        list = [];
      }

      list.add(map);

      saveData(list);
    });
  }

  Future<List> readData() async {
    try {
      final file = await _getFile();

      String data = await file.readAsStringSync();

      return json.decode(data);
    } catch (e) {
      return null;
    }
  }

}
