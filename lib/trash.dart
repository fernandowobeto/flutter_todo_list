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
          leading: Icon(Icons.add),
          title: Text(_trashList[index]["title"]),
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          Map<String, dynamic> copied = Map.from(_trashList[index]);

          _doneModel.addData(copied);

          _trashList.removeAt(index);

          _trashModel.saveData(_trashList);
        });
      },
    );
  }
}
