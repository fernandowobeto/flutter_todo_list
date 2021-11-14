import 'package:flutter/material.dart';
import 'ToDoModel.dart';
import 'DoneModel.dart';

class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  final _toDoController = TextEditingController();
  final _dataModel = ToDoModel();
  final _doneModel = DoneModel();

  List _toDoList = [];

  @override
  void initState() {
    super.initState();

    _dataModel.readData().then((list) {
      setState(() {
        if (list != null) {
          _toDoList = list;
        }
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      _toDoController.text = "";
      _toDoList.add(newToDo);

      _dataModel.saveData(_toDoList);
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
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.green,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.done_all,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: Card(
        child: ListTile(
          leading: Icon(Icons.add),
          title: Text(_toDoList[index]["title"]),
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          Map<String, dynamic> copied = Map.from(_toDoList[index]);

          _doneModel.addData(copied);

          _toDoList.removeAt(index);

          _dataModel.saveData(_toDoList);
        });
      },
    );
  }
}
