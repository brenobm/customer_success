import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class CustomerSuccessContext  {

  Database database;

  Future open() async {
    await _initialize();
  }

  Future _initialize() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'customerSuccess.db');

    database = await openDatabase(
      path, 
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Client (id INTEGER PRIMARY KEY, name TEXT)");
      }
    );

    database;
  }
}