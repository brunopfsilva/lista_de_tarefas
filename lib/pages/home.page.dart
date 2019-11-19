import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _salvarArquivo() async {

    final diretorio = await getApplicationDocumentsDirectory();
    print("Caminho: ${diretorio}");
    var arquivo = File ( "${diretorio.path}/dados.json" );

    //criar dados
    Map<String,dynamic> tarefa = Map();
    tarefa["titulo"] = "ir ao mercado";
    tarefa["realizada"] = false;
    _listTarefas.add( tarefa );

    //convert a lista para json
    String dados = json.encode(_listTarefas);

    arquivo.writeAsStringSync(dados);

  }

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
                    FlatButton(
                      child: Text("Cancelar"),
                      onPressed: () => Navigator.pop(context),
                    ),FlatButton(
                      child: Text("Salvar"),
                      onPressed: (){
                        //save task
                        _salvarArquivo();
                      },
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
