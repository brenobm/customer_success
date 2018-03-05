import 'package:flutter/material.dart';
import 'Views/ClientCadastrePage.dart';
import 'Views/ClientListPage.dart';

void main() => runApp(new CustomerSuccessApp());

class CustomerSuccessApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Customer Success',
      home: new HomePage(),
      routes: <String, WidgetBuilder> {
        '/clientCadastre': (BuildContext context) => new ClientCadastrePage(),
        '/clientList': (BuildContext context) => new ClientListPage(),
      },
    );
  } 
}

class HomePage extends StatefulWidget {
  @override
  StatefulWidgetState createState() => new StatefulWidgetState();
}

class StatefulWidgetState extends State<StatefulWidget>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Customer Success'),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Text('Bem vindo ao Customer Sucess'),
            new FlatButton(
              child: new Text('Cadastro de Clientes'),
              onPressed: () {
                Navigator.of(context).pushNamed('/clientCadastre');
              },
            ),
            new FlatButton(
              child: new Text('Listar Clientes'),
              onPressed: () {
                Navigator.of(context).pushNamed('/clientList');
              },
            ),
          ],
        ),
      ),
    );
  }
}
