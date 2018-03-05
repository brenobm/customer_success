abstract class BaseModel {
  final String columnId = "id";
  String tableName;
  List<String> fieldNames;

  int id;

  Map toMap();
}

class ClientModel extends BaseModel {
  final String columnName = "name";

  String name;

  @override
  Map toMap() {
    Map map = { columnName: name };

    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }

  void initialize() {
     fieldNames = [columnId, columnName];
     tableName = 'Client';
  }

  ClientModel() {
    initialize();
  }

  ClientModel.fromMap(Map map) {
    initialize();

    id = map[columnId];
    name = map[columnName];
  }
}

