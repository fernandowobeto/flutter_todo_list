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
          title: Text('Lista de Tarefas'),
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