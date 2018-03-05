import 'dart:async';

import 'package:flutter/material.dart';

import '../Models/models.dart';
import '../DataAccess/Repositories/ClientRepository.dart';

class ClientListPage extends StatefulWidget {
  @override
  ClientListPageState createState() => new ClientListPageState();
}

class ClientListPageState extends State<ClientListPage>{

  List<ClientModel> _clients; 

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future _initialize() async {
    ClientRepository repository = new ClientRepository();
    await repository.open();
    _clients = await repository.getAll();
    await repository.close();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Cadastro de Cliente'),
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(bottom: 15.0),
            child: new Text(
              'Cliente Cadastrados',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),              
            ),
          ),
          new Card(
            child: await _buildClientList(),
          )
        ],
      ),
    );
  }

  Future<Widget> _buildClientList() async {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: await (context, i) async {
        if (_clients == null) {
          await _initialize();
        }

        return new _ClientListItem(_clients[i]);
      },
    );

    return _clients.map((contact) => new _ClientListItem(contact))
                    .toList();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value)
    ));

  }
}

class _ClientListItem extends StatelessWidget {
  final ClientModel _client;
  _ClientListItem(this._client);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(_client.name),
    );
  }
}