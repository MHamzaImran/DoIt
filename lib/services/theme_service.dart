import 'package:todolist_sqflite/helpers/models/repositories/repository.dart';

import '../helpers/models/theme.dart';

class ThemeService {
  final Repository _repository = Repository();

  saveTheme(DatabaseTheme theme) async {
    var result = await _repository.insertThemeData('theme', theme.themeMap());
    return result;
  }

  readTheme() async {
    return await _repository.readThemeData('theme');
  }

  deleteTheme() async {
    return await _repository.deleteThemeData('theme');
  }

  updateTheme(DatabaseTheme theme) async {
    var result = await _repository.updateThemeData('theme', theme.themeMap());
    return result;
  }
}
