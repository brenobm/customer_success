import 'dart:async';

import '../CustomerSuccessContext.dart';
import '../../Models/models.dart';

class ClientRepository {
  CustomerSuccessContext context;

  ClientRepository() {
    context = new CustomerSuccessContext();
  }

  Future open() async {
    await context.open();
  }

  Future<ClientModel> insert(ClientModel entity) async {
    entity.id = await context.database.insert(entity.tableName, entity.toMap());

    return entity;
  }

  Future<ClientModel> get(int id) async {
    ClientModel tmp = new ClientModel();


    List<Map> maps = await context.database.query(
      tmp.tableName, 
      columns: tmp.fieldNames,
      where: '${tmp.columnId} = ?',
      whereArgs: [id]);

    if (maps.length > 0) {
      return new ClientModel.fromMap(maps.first);
    }

    return null;
  }

  Future<int> delete(int id) async {
    ClientModel tmp = new ClientModel();

    return await context.database.delete(tmp.tableName, where: "$tmp.columnId = ?", whereArgs: [id]);
  }

  Future<int> update(ClientModel entity) async {
    
    return await context.database.update(entity.tableName, entity.toMap(),
        where: "$entity.columnId = ?", whereArgs: [entity.id]);
  }

  Future close() async => context.database.close();

}
