import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listTarefas = ["Ir ao mercado", "Estudar", "Exercicio do dia"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: _listTarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_listTarefas[index]),
                );
              }),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        //floatingActionButton: FloatingActionButton(
        // child: Icon(Icons.add),
        icon: Icon(Icons.add),
        label: Text("Add"),
        elevation: 9,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Adicionar Lista de Tarefa"),
                  content: TextField(
                    decoration: InputDecoration(labelText: "Digite sua tarefa"),
                    onChanged: (text) {},
                  ),
                  actions: <Widget>[
                    // a implementar
                  ],
                );
              });
        },
      ),
    );
  }
}
