import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_todolist_sqflite');
    var database =
        await openDatabase(path, version: 1, onCreate: onCreatingDatabase);
    return database;
  }

  onCreatingDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT)");
    await database.execute(
        "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, category TEXT, todoDate TEXT, IsFinished INTEGER)");
    await database.execute(
        'CREATE TABLE theme(id INTEGER PRIMARY KEY, kAppbarColor INTEGER, kAppbarText INTEGER, kTextColor INTEGER, kBackgroundColor INTEGER, kTileColor INTEGER, kTileText INTEGER, kFloatColor INTEGER, kFloatText INTEGER, kDrawerUpperText INTEGER, kDrawerLowerText INTEGER)');
    await database.execute(
        'CREATE TABLE profile(id INTEGER PRIMARY KEY, image LONGBLOB, name TEXT, email TEXT)');
  }
}
