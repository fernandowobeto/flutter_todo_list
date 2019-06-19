import 'package:flutter/material.dart';

import 'todo.dart';
import 'done.dart';
import 'trash.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DefaultTabController(
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
    ),
  ));
}
