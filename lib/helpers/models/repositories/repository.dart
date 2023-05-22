import 'package:sqflite/sqflite.dart';
import 'package:todolist_sqflite/helpers/models/repositories/database_connection.dart';

class Repository {
  final DatabaseConnection _databaseConnection = DatabaseConnection();
  static Database? _database;

  Future<Database> get database async =>
      _database ??= await _databaseConnection.setDatabase();

  insertData(table, data) async {
    data['id'] = null;
    var connection = await database;
    var result = await connection.insert(table, data);
    return result;
  }

  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  readDataById(table, itemId) async {
    var connection = await database;
    var result =
        await connection.query(table, where: 'id = ?', whereArgs: [itemId]);
    return result[0];
  }

  updateData(table, data) async {
    var connection = await database;
    var result = await connection
        .update(table, data, where: 'id = ?', whereArgs: [data['id']]);
    return result;
  }

  deleteData(table, itemId) async {
    var connection = await database;
    return await connection.rawDelete('DELETE FROM $table WHERE id = $itemId');
  }

  readDataByColumnName(table, columnName, columnValue) async {
    var connection = await database;
    var result = await connection
        .query(table, where: '$columnName=?', whereArgs: [columnValue]);
    return result;
  }

  insertThemeData(table, data) async {
    var connection = await database;
    var result = await connection.insert(table, data);
    return result;
  }

  readThemeData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  deleteThemeData(table) async {
    var connection = await database;
    return await connection.rawDelete('DELETE FROM $table');
  }

  updateThemeData(table, data) async {
    var connection = await database;
    var result = await connection
        .update(table, data, where: 'id = ?', whereArgs: [data['id']]);
    return result;
  }
  insertProfileData(table, data) async {
    var connection = await database;
    var result = await connection.insert(table, data);
    return result;
  }

  deleteProfileData(table) async {
    var connection = await database;
    return await connection.rawDelete('DELETE FROM $table');
  }

  readProfileData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

}
