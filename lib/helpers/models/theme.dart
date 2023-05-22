import 'package:todolist_sqflite/helpers/models/repositories/database_connection.dart';

class DatabaseTheme{
  DatabaseConnection databaseConnection = DatabaseConnection();
  var kAppbarColor;
  var kAppbarText;
  var kTextColor ;
  var kBackgroundColor;
  var kTileColor ;
  var kTileText ;
  var kFloatColor;
  var kFloatText;
  var kDrawerUpperText;
  var kDrawerLowerText;

  themeMap(){
    var mapping = <String, dynamic>{};
    mapping['kAppbarColor'] = kAppbarColor;
    mapping['kAppbarText'] = kAppbarText;
    mapping['kTextColor'] = kTextColor;
    mapping['kBackgroundColor'] = kBackgroundColor;
    mapping['kTileColor'] = kTileColor;
    mapping['kTileText'] = kTileText;
    mapping['kFloatColor'] = kFloatColor;
    mapping['kFloatText'] = kFloatText;
    mapping['kDrawerUpperText'] = kDrawerUpperText;
    mapping['kDrawerLowerText'] = kDrawerLowerText;
    return mapping;
  }
}
