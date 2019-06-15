import 'package:flutter/material.dart';
import 'ToDoModel.dart';
import 'DoneModel.dart';
import 'TrashModel.dart';

class Done extends StatefulWidget {
  @override
  _DoneState createState() => _DoneState();
}

class _DoneState extends State<Done> {
  List _doneList = [];

  ToDoModel _toDoModel = ToDoModel();
  DoneModel _doneModel = DoneModel();
  TrashModel _trashModel = TrashModel();

  @override
  void initState() {
    super.initState();

    _doneModel.readData().then((list) {
      setState(() {
        if (list != null) {
          _doneList = list;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0),
              itemCount: _doneList.length,
              itemBuilder: buildItem),
        )
      ],
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.blue,
        child: Align(
          alignment: Alignment(0.9, 0.0),
          child: Icon(
            Icons.add_box,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.horizontal,
      child: Card(
        child: ListTile(
          leading: Icon(Icons.add),
          title: Text(_doneList[index]["title"]),
        ),
      ),
      onDismissed: (DismissDirection direction) {
        Map<String, dynamic> copied = Map.from(_doneList[index]);

        if(direction == DismissDirection.startToEnd){
          _trashModel.addData(copied);
        }else{
          _toDoModel.addData(copied);
        }

        setState(() {
          _doneList.removeAt(index);
          _doneModel.saveData(_doneList);
        });
      },
    );
  }
}
