import 'package:flutter/material.dart';

import '../Models/models.dart';
import '../DataAccess/Repositories/ClientRepository.dart';

class ClientCadastrePage extends StatefulWidget {
  @override
  ClientCadastrePageState createState() => new ClientCadastrePageState();
}

class ClientCadastrePageState extends State<ClientCadastrePage>{

  ClientModel _client = new ClientModel();

  final TextEditingController _nameController = new TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Cadastro de Cliente'),
      ),
      body: new Form(
        key: _formKey,
        autovalidate: _autovalidate,
        //onWillPop: _warnUserAboutInvalidData,
        child: new Container(
          padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
          child: new Column(
            children: [
              new Container(
                margin: const EdgeInsets.only(bottom: 15.0),
                child: new Text(
                  'Cadastro de Cliente',
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),              
                ),
              ),
              new Card(
                child: new Column(
                  children: <Widget>[
                    _buildField('name', 'Nome'),
                    _buildButtons(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String name, String label) {
    return new Container(
      padding: const EdgeInsets.all(15.0),
        child: new TextFormField(
          maxLines: 1,
          decoration: new InputDecoration(
            labelText: label,
            labelStyle: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            hintText: label,
          ),
          onSaved: (String name) { _client.name = name; },
          validator: _validateName,
          controller: _nameController,
      ),
    );
  }

  Widget _buildButtons()
  {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new IconButton(
          icon: new Icon(
            Icons.save,
            color: Colors.green[200],
          ),
          onPressed: _cadastreClientAction,
          tooltip: 'Salvar',
        ),

        new IconButton(
          icon: new Icon(
            Icons.cancel,
            color: Colors.red[200],
          ),          
          onPressed: () { Navigator.of(context).pop(); },
          tooltip: 'Cancelar',
        ),
      ],
    );
  }


  String _validateName(String value) {
    if (value.isEmpty)
      return 'O Nome é necessário.';

    return null;
  }

  void _cadastreClientAction() async {
    final FormState form = _formKey.currentState;
    
    if (form.validate()) {
      form.save();

      ClientRepository repository = new ClientRepository();

      await repository.open();

      await repository.insert(_client);

      await repository.close();

      _nameController.text = '';

      showInSnackBar('Client "${_client.name}" salvo com sucesso!');
    } else {
      _autovalidate = true;
      showInSnackBar('Dados estão incorretos.');
    }
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value)
    ));

  }
}