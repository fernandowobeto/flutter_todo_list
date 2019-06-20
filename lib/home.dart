import 'package:flutter/material.dart';

import 'todo.dart';
import 'done.dart';
import 'trash.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.add_box), text: 'Fazer',),
              Tab(icon: Icon(Icons.done_all), text: 'Feito',),
              Tab(icon: Icon(Icons.restore_from_trash), text: 'Lixeira',)
            ],
          ),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text('Lista de Tarefas'),
              ),
              IconButton(
                icon: Icon(Icons.help),
                color: Colors.white,
                onPressed: (){
                  _showDialog();
                },
                alignment: Alignment(1.0, 0.0),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ToDo(),
            Done(),
            Trash(),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Sobre"),
          content: new Text("Desenvolvido por Fernando Wobeto"),
          actions: <Widget>[
            FlatButton(
              child: new Text("Fechar"),
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