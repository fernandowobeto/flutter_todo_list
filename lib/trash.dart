import 'package:flutter/material.dart';
import 'TrashModel.dart';
import 'DoneModel.dart';

class Trash extends StatefulWidget {
  @override
  _TrashState createState() => _TrashState();
}

class _TrashState extends State<Trash> {
  List _trashList = [];

  TrashModel _trashModel = TrashModel();
  DoneModel _doneModel = DoneModel();

  @override
  void initState() {
    super.initState();

    _trashModel.readData().then((list) {
      setState(() {
        if (list != null) {
          _trashList = list;
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
              itemCount: _trashList.length,
              itemBuilder: buildItem),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () {
                if(_trashList.length > 0){
                  _showDialog();
                }
              },
              child: Icon(Icons.clear),
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              elevation: 3.0,
              heroTag: "fab",
            ),
          ),
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
          alignment: Alignment(0.9, 0.0),
          child: Icon(
            Icons.done_all,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      child: Card(
        child: ListTile(
          leading: Icon(Icons.delete),
          title: Text(_trashList[index]["title"]),
        ),
      ),
      onDismissed: (direction) {
        Map<String, dynamic> copied = Map.from(_trashList[index]);

        _doneModel.addData(copied);

        setState(() {
          _trashList.removeAt(index);

          _trashModel.saveData(_trashList);
        });
      },
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirma?"),
          content: new Text("Deseja mesmo limpar a lixeira?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            FlatButton(
              child: new Text("Confirma"),
              onPressed: () {
                setState(() {
                  _trashList = [];

                  _trashModel.saveData(_trashList);

                  Navigator.of(context).pop();
                });
              },
            ),
            FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

}
