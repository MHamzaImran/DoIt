import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_sqflite/helpers/models/theme.dart';
import 'package:todolist_sqflite/src/app.dart';
import '../services/theme_service.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        CustomTile(title: 'Dark', tileColor: Colors.black),
        CustomTile(title: 'Default', tileColor: const Color(0xFF03A9F4)),
        CustomTile(title: 'Red', tileColor: const Color(0xFFF44336)),
        CustomTile(title: 'Pink', tileColor: const Color(0xFFE91E63)),
        CustomTile(title: 'Purple', tileColor: const Color(0xFF9C27B0)),
        CustomTile(title: 'Deep Purple', tileColor: const Color(0xFF673AB7)),
        CustomTile(title: 'Indigo', tileColor: const Color(0xFF3F51B5)),
        CustomTile(title: 'Blue', tileColor: const Color(0xFF2196F3)),
        CustomTile(title: 'Cyan', tileColor: const Color(0xFF0097A7)),
        CustomTile(title: 'Teal', tileColor: const Color(0xFF00796B)),
        CustomTile(title: 'Green', tileColor: const Color(0xFF4CAF50)),
        CustomTile(title: 'Light Green', tileColor: const Color(0xFF8BC34A)),
        CustomTile(title: 'Lime', tileColor: const Color(0xFFCDDC39)),
        CustomTile(title: 'Yellow', tileColor: const Color(0xFFFFEB3B)),
        CustomTile(title: 'Amber', tileColor: const Color(0xFFFFCA28)),
        CustomTile(title: 'Orange', tileColor: const Color(0xFFFF9800)),
        CustomTile(title: 'Deep Orange', tileColor: const Color(0xFFFF7043)),
        CustomTile(title: 'Brown', tileColor: const Color(0xFF795548)),
        CustomTile(title: 'Gray', tileColor: const Color(0xFF757575)),
        CustomTile(title: 'Blue Gray', tileColor: const Color(0xFF607DAB)),
      ],
    ));
  }
}

class CustomTile extends StatefulWidget {
  CustomTile({required this.title, required this.tileColor});
  final String title;
  final Color tileColor;

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  var kAppbarColor;
  var kAppbarText;
  var kTextColor;
  var kBackgroundColor;
  var kTileColor;
  var kTileText;
  var kFloatColor;
  var kFloatText;
  var kDrawerUpperText;
  var kDrawerLowerText;
  final _theme = DatabaseTheme();
  final _themeService = ThemeService();
  var theme = [];

  saveThemeToDatabase(
      int kAppbarColor,
      int kAppbarText,
      int kTextColor,
      int kBackgroundColor,
      int kTileColor,
      int kTileText,
      int kFloatColor,
      int kFloatText,
      int kDrawerUpperText,
      int kDrawerLowerText) async {
    _theme.kAppbarColor = kAppbarColor;
    _theme.kAppbarText = kAppbarText;
    _theme.kTextColor = kTextColor;
    _theme.kBackgroundColor = kBackgroundColor;
    _theme.kTileColor = kTileColor;
    _theme.kTileText = kTileText;
    _theme.kFloatColor = kFloatColor;
    _theme.kFloatText = kFloatText;
    _theme.kDrawerUpperText = kDrawerUpperText;
    _theme.kDrawerLowerText = kDrawerLowerText;
    await _themeService.saveTheme(_theme);
  }

  deleteThemeData() async {
    await _themeService.deleteTheme();
  }

  /*
  ---------------------------------------------------------
  Take input title on pressing theme tile
  Pass all the colors to the notifier class as parameters
  delete previous theme data if any
  save new theme in database
  */

  /// call themeFromDatabase notifier class with if else statements, delete theme and save theme
  void changeTileTheme(String title) {
    if (title == 'Dark') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF000000),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFF303030),
        const Color(0xFF424242),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFF000000),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF000000,
          kAppbarText = 0xFFFFFFFF,
          kTextColor = 0xFFFFFFFF,
          kBackgroundColor = 0xFF303030,
          kTileColor = 0xFF424242,
          kTileText = 0xFFFFFFFF,
          kFloatColor = 0xFFFFFFFF,
          kFloatText = 0xFF000000,
          kDrawerUpperText = 0xFFFFFFFF,
          kDrawerLowerText = 0xFFFFFFFF);
    } else if (title == 'Default') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF03A9F4),
        const Color(0xFFFFFFFF),
        const Color(0xFF000000),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFF000000),
        const Color(0xFF03A9F4),
        const Color(0xFFFFFFFF),
        const Color(0xFF000000),
        const Color(0xFF000000),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF03A9F4,
          kAppbarText = 0xFFFFFFFF,
          kTextColor = 0xFF000000,
          kBackgroundColor = 0xFFFFFFFF,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF000000,
          kFloatColor = 0xFF03A9F4,
          kFloatText = 0xFFFFFFFF,
          kDrawerUpperText = 0xFF000000,
          kDrawerLowerText = 0xFF000000);
    } else if (title == 'Red') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFFF44336),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFEF9A9A),
        const Color(0xFFFFFFFF),
        const Color(0xFFF44336),
        const Color(0xFFF44336),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFFF44336,
          kAppbarText = 0xFFFFFFFF,
          kTextColor = 0xFFFFFFFF,
          kBackgroundColor = 0xFFEF9A9A,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFFF44336,
          kFloatColor = 0xFFF44336,
          kFloatText = 0xFFFFFFFF,
          kDrawerUpperText = 0xFFFFFFFF,
          kDrawerLowerText = 0xFFFFFFFF);
    } else if (title == 'Pink') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFFE91E63),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFEF9A9A),
        const Color(0xFFF48FB1),
        const Color(0xFFFFFFFF),
        const Color(0xFFE91E63),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFFE91E63,
          kAppbarText = 0xFFFFFFFF,
          kTextColor = 0xFFFFFFFF,
          kBackgroundColor = 0xFFEF9A9A,
          kTileColor = 0xFFF48FB1,
          kTileText = 0xFFFFFFFF,
          kFloatColor = 0xFFE91E63,
          kFloatText = 0xFFFFFFFF,
          kDrawerUpperText = 0xFFFFFFFF,
          kDrawerLowerText = 0xFFFFFFFF);
    } else if (title == 'Purple') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF9C27B0),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFCE93D8),
        const Color(0xFFFFFFFF),
        const Color(0xFFAB47BC),
        const Color(0xFFAB47BC),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF9C27B0,
          kAppbarText = 0xFFFFFFFF,
          kTextColor = 0xFFFFFFFF,
          kBackgroundColor = 0xFFCE93D8,
          kTileColor = 0xFFF48FB1,
          kTileText = 0xFFAB47BC,
          kFloatColor = 0xFFAB47BC,
          kFloatText = 0xFFFFFFFF,
          kDrawerUpperText = 0xFFFFFFFF,
          kDrawerLowerText = 0xFFFFFFFF);
    } else if (title == 'Deep Purple') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF673AB7),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFB39DDB),
        const Color(0xFFFFFFFF),
        const Color(0xFF673AB7),
        const Color(0xFF673AB7),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF673AB7,
          kAppbarText = 0xFFFFFFFF,
          kTextColor = 0xFFFFFFFF,
          kBackgroundColor = 0xFFB39DDB,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF673AB7,
          kFloatColor = 0xFF673AB7,
          kFloatText = 0xFFFFFFFF,
          kDrawerUpperText = 0xFFFFFFFF,
          kDrawerLowerText = 0xFFFFFFFF);
    } else if (title == 'Indigo') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF3F51B5),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFF9FA8DA),
        const Color(0xFFFFFFFF),
        const Color(0xFF3F51B5),
        const Color(0xFF3F51B5),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF3F51B5,
          kAppbarText = 0xFFFFFFFF,
          kTextColor = 0xFFFFFFFF,
          kBackgroundColor = 0xFF9FA8DA,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF3F51B5,
          kFloatColor = 0xFF3F51B5,
          kFloatText = 0xFFFFFFFF,
          kDrawerUpperText = 0xFFFFFFFF,
          kDrawerLowerText = 0xFFFFFFFF);
    } else if (title == 'Blue') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF2196F3),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFF90CAF9),
        const Color(0xFFFFFFFF),
        const Color(0xFF2196F3),
        const Color(0xFF2196F3),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF2196F3,
          kAppbarText = 0xFFFFFFFF,
          kTextColor = 0xFFFFFFFF,
          kBackgroundColor = 0xFF90CAF9,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF2196F3,
          kFloatColor = 0xFF2196F3,
          kFloatText = 0xFFFFFFFF,
          kDrawerUpperText = 0xFFFFFFFF,
          kDrawerLowerText = 0xFFFFFFFF);
    } else if (title == 'Cyan') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF0097A7),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFF80DEEA),
        const Color(0xFFFFFFFF),
        const Color(0xFF0097A7),
        const Color(0xFF0097A7),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF0097A7,
          kAppbarText = 0xFFFFFFFF,
          kTextColor = 0xFFFFFFFF,
          kBackgroundColor = 0xFF80DEEA,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF0097A7,
          kFloatColor = 0xFF0097A7,
          kFloatText = 0xFFFFFFFF,
          kDrawerUpperText = 0xFFFFFFFF,
          kDrawerLowerText = 0xFFFFFFFF);
    } else if (title == 'Teal') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF00796B),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFF80CBC4),
        const Color(0xFFFFFFFF),
        const Color(0xFF00796B),
        const Color(0xFF00796B),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF00796B,
          kAppbarText = 0xFFFFFFFF,
          kTextColor = 0xFFFFFFFF,
          kBackgroundColor = 0xFF80CBC4,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF00796B,
          kFloatColor = 0xFF00796B,
          kFloatText = 0xFFFFFFFF,
          kDrawerUpperText = 0xFFFFFFFF,
          kDrawerLowerText = 0xFFFFFFFF);
    } else if (title == 'Green') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF4CAF50),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFA5D6A7),
        const Color(0xFFFFFFFF),
        const Color(0xFF4CAF50),
        const Color(0xFF4CAF50),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF4CAF50,
          kAppbarText = 0xFFFFFFFF,
          kTextColor = 0xFFFFFFFF,
          kBackgroundColor = 0xFFA5D6A7,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF4CAF50,
          kFloatColor = 0xFF4CAF50,
          kFloatText = 0xFFFFFFFF,
          kDrawerUpperText = 0xFFFFFFFF,
          kDrawerLowerText = 0xFFFFFFFF);
    } else if (title == 'Light Green') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF8BC34A),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFC5E1A5),
        const Color(0xFFFFFFFF),
        const Color(0xFF8BC34A),
        const Color(0xFF8BC34A),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF8BC34A,
          kAppbarText = 0xFFFFFFFF,
          kTextColor = 0xFFFFFFFF,
          kBackgroundColor = 0xFFC5E1A5,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF8BC34A,
          kFloatColor = 0xFF8BC34A,
          kFloatText = 0xFFFFFFFF,
          kDrawerUpperText = 0xFFFFFFFF,
          kDrawerLowerText = 0xFFFFFFFF);
    } else if (title == 'Lime') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFFCDDC39),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFFE6EE9C),
        const Color(0xFFFFFFFF),
        const Color(0xFFCDDC39),
        const Color(0xFFCDDC39),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFF000000),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFFCDDC39,
          kAppbarText = 0xFF000000,
          kTextColor = 0xFF000000,
          kBackgroundColor = 0xFFE6EE9C,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFFCDDC39,
          kFloatColor = 0xFFCDDC39,
          kFloatText = 0xFF000000,
          kDrawerUpperText = 0xFF000000,
          kDrawerLowerText = 0xFF000000);
    } else if (title == 'Yellow') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFFFFEB3B),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFFFFF59D),
        const Color(0xFFFFFFFF),
        const Color(0xFF000000),
        const Color(0xFFFFEB3B),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFF000000),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFFFFEB3B,
          kAppbarText = 0xFF000000,
          kTextColor = 0xFF000000,
          kBackgroundColor = 0xFFFFF59D,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF000000,
          kFloatColor = 0xFFFFEB3B,
          kFloatText = 0xFF000000,
          kDrawerUpperText = 0xFF000000,
          kDrawerLowerText = 0xFF000000);
    } else if (title == 'Amber') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFFFFCA28),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFFFFE082),
        const Color(0xFFFFFFFF),
        const Color(0xFF000000),
        const Color(0xFFFFCA28),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFF000000),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFFFFCA28,
          kAppbarText = 0xFF000000,
          kTextColor = 0xFF000000,
          kBackgroundColor = 0xFFFFE082,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF000000,
          kFloatColor = 0xFFFFCA28,
          kFloatText = 0xFF000000,
          kDrawerUpperText = 0xFF000000,
          kDrawerLowerText = 0xFF000000);
    } else if (title == 'Orange') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFFFF9800),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFFFFCC80),
        const Color(0xFFFFFFFF),
        const Color(0xFF000000),
        const Color(0xFFFF9800),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFF000000),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFFFF9800,
          kAppbarText = 0xFF000000,
          kTextColor = 0xFF000000,
          kBackgroundColor = 0xFFFFCC80,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF000000,
          kFloatColor = 0xFFFF9800,
          kFloatText = 0xFF000000,
          kDrawerUpperText = 0xFF000000,
          kDrawerLowerText = 0xFF000000);
    } else if (title == 'Deep Orange') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFFFF7043),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFFFFAB91),
        const Color(0xFFFFFFFF),
        const Color(0xFF000000),
        const Color(0xFFFF7043),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFF000000),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFFFF7043,
          kAppbarText = 0xFF000000,
          kTextColor = 0xFF000000,
          kBackgroundColor = 0xFFFFAB91,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF000000,
          kFloatColor = 0xFFFF7043,
          kFloatText = 0xFF000000,
          kDrawerUpperText = 0xFF000000,
          kDrawerLowerText = 0xFF000000);
    } else if (title == 'Brown') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF795548),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFFBCAAA4),
        const Color(0xFFFFFFFF),
        const Color(0xFF000000),
        const Color(0xFF795548),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFF000000),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF795548,
          kAppbarText = 0xFF000000,
          kTextColor = 0xFF000000,
          kBackgroundColor = 0xFFBCAAA4,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF000000,
          kFloatColor = 0xFF795548,
          kFloatText = 0xFF000000,
          kDrawerUpperText = 0xFF000000,
          kDrawerLowerText = 0xFF000000);
    } else if (title == 'Gray') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF757575),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFFEEEEEE),
        const Color(0xFFFFFFFF),
        const Color(0xFF000000),
        const Color(0xFF757575),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFF000000),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF757575,
          kAppbarText = 0xFF000000,
          kTextColor = 0xFF000000,
          kBackgroundColor = 0xFFEEEEEE,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF000000,
          kFloatColor = 0xFF757575,
          kFloatText = 0xFF000000,
          kDrawerUpperText = 0xFF000000,
          kDrawerLowerText = 0xFF000000);
    } else if (title == 'Blue Gray') {
      Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        const Color(0xFF607DAB),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFFB0BEC5),
        const Color(0xFFFFFFFF),
        const Color(0xFF000000),
        const Color(0xFF607DAB),
        const Color(0xFF000000),
        const Color(0xFF000000),
        const Color(0xFF000000),
      );
      deleteThemeData();
      saveThemeToDatabase(
          kAppbarColor = 0xFF607DAB,
          kAppbarText = 0xFF000000,
          kTextColor = 0xFF000000,
          kBackgroundColor = 0xFFB0BEC5,
          kTileColor = 0xFFFFFFFF,
          kTileText = 0xFF000000,
          kFloatColor = 0xFF607DAB,
          kFloatText = 0xFF000000,
          kDrawerUpperText = 0xFF000000,
          kDrawerLowerText = 0xFF000000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
          child: Text(
        widget.title,
        style: const TextStyle(color: Colors.white),
      )),
      tileColor: widget.tileColor,
      onTap: () {
        changeTileTheme(widget.title);
        Navigator.pop(context);
      },
    );
  }
}
