import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/homeScreen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (BuildContext context) => ThemeChanger(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

class ThemeChanger extends ChangeNotifier {
  var kAppbarColor = const Color(0xFF03A9F4); //lightBlueAccent[900]
  var kAppbarText = Colors.white;
  var kTextColor = Colors.black;
  var kBackgroundColor = Colors.white;
  var kTileColor = Colors.white;
  var kTileText = Colors.black;
  var kFloatColor = const Color(0xFF03A9F4);
  var kFloatText = Colors.white;
  var kDrawerUpperText = Colors.white;
  var kDrawerLowerText = Colors.black;

  void themeFromDatabase(
      Color kAppbarColor,
      Color kAppbarText,
      Color kTextColor,
      Color kBackgroundColor,
      Color kTileColor,
      Color kTileText,
      Color kFloatColor,
      Color kFloatText,
      Color kDrawerUpperText,
      Color kDrawerLowerText) {
    this.kAppbarColor = kAppbarColor;
    this.kAppbarText = kAppbarText;
    this.kTextColor = kTextColor;
    this.kBackgroundColor = kBackgroundColor;
    this.kTileColor = kTileColor;
    this.kTileText = kTileText;
    this.kFloatColor = kFloatColor;
    this.kFloatText = kFloatText;
    this.kDrawerUpperText = kDrawerUpperText;
    this.kDrawerLowerText = kDrawerLowerText;
    notifyListeners();
  }
}
