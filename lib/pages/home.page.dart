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

  List _listaTarefas = [];


 Future<File> _getFile ( ) async {

    final diretorio = await getApplicationDocumentsDirectory();
    return File ( "${diretorio.path}/dados.json" );

  }


  _lerArquivo () async {
    try{

      final arquivo = await _getFile();
      return arquivo.readAsString();

    }
    catch(e){
      return null;
    }
  }

  _salvarArquivo() async {

    var arquivo = await _getFile();

    //criar dados
    Map<String,dynamic> tarefa = Map();
    tarefa["titulo"] = "ir ao mercado";
    tarefa["realizada"] = false;
    _listaTarefas.add( tarefa );

    //convert a lista para json
    String dados = json.encode(_listaTarefas);

    arquivo.writeAsStringSync(dados);

  }


  @override
  void initState() {
    super.initState();
    //leia o arquivo então depois de lido faça()then recebe uma funcao anonima
    _lerArquivo().then((dados){

      setState(() {
        //convert novamente para lista
        _listaTarefas = json.decode(dados);

      });

    });
  }

  @override
  Widget build(BuildContext context) {

    _salvarArquivo();

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: _listaTarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_listaTarefas[index]['titulo']),
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
