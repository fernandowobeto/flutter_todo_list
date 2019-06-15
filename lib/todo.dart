import 'package:flutter/material.dart';
import 'DataModel.dart';

class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  final _toDoController = TextEditingController();
  final _dataModel = DataModel();

  List _toDoList = [];

  @override
  void initState() {
    super.initState();

    _dataModel.readData().then((map) {
      setState(() {
        var data = map;

        if (data == null) {
          data = _dataModel.createInitialJsonData();
        }

        _toDoList = data['todo'];
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      newToDo["status"] = 0;
      _toDoController.text = "";
      _toDoList.add(newToDo);

      _dataModel.saveTodoData(newToDo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: TextField(
                controller: _toDoController,
                decoration: InputDecoration(
                    labelText: "Nova Tarefa",
                    labelStyle: TextStyle(color: Colors.blueAccent)),
              )),
              RaisedButton(
                color: Colors.blueAccent,
                child: Text("ADD"),
                textColor: Colors.white,
                onPressed: _addToDo,
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0),
              itemCount: _toDoList.length,
              itemBuilder: buildItem),
        )
      ],
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.add),
        title: Text(_toDoList[index]["title"]),
      ),
    );
  }
}
