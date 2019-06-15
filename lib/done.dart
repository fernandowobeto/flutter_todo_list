import 'package:flutter/material.dart';

import 'DataModel.dart';


class Done extends StatefulWidget {
  @override
  _DoneState createState() => _DoneState();
}

class _DoneState extends State<Done> {

  DataModel _dataModel = DataModel();

  List _toDoList = [];

  @override
  void initState() {
    super.initState();

    _dataModel.readData().then((map) {
      setState(() {
        _toDoList = map["done"];
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
              itemCount: _toDoList.length,
              itemBuilder: buildItem
          ),
        )
      ],
    );
  }

  Widget buildItem(BuildContext context, int index){
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white,),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]["title"]),
        value: _toDoList[index]["ok"],
        secondary: CircleAvatar(
          child: Icon(Icons.done),),
        onChanged: (c){
          setState(() {
            _toDoList[index]["ok"] = 2;
            _dataModel.saveDoneData(_toDoList[index]);
          });
        },
      ),
      onDismissed: (direction){
        setState(() {
          final snack = SnackBar(
            content: Text("Tarefa \"${_toDoList[index]["title"]}\" removida!"),
            action: SnackBarAction(label: "Desfazer",
                onPressed: () {

                }),
            duration: Duration(seconds: 2),
          );

          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);

        });
      },
    );
  }

}

