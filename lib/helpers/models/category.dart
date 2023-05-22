import 'package:todolist_sqflite/helpers/models/repositories/database_connection.dart';

class Category{
  DatabaseConnection databaseConnection = DatabaseConnection();
  var id;
  var name ;
  var description;
  categoryMap(){
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['description'] = description;
    return mapping;
  }
}




