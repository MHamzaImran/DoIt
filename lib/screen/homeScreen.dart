import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_sqflite/helpers/drawer_navigation.dart';
import 'package:todolist_sqflite/screen/todo_screen.dart';
import 'package:todolist_sqflite/services/todo_services.dart';
import '../helpers/models/theme.dart';
import '../helpers/models/todo.dart';
import '../services/theme_service.dart';
import '../src/app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _todoService = TodoService();
  List<Todo> _todoList = <Todo>[];

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
  final _themeService = ThemeService();
  List<DatabaseTheme> _themeList = <DatabaseTheme>[];
  var theme = [];

  @override
  void initState() {
    super.initState();
    getAllThemes();
    getAllTodos();
  }

  /// Get all todos from database and build the screen
  getAllTodos() async {
    _todoService = TodoService();
    _todoList = <Todo>[];
    var todos = await _todoService.readTodo();
    todos.forEach((todos) {
      setState(() {
        var model = Todo();
        model.id = todos['id'];
        model.title = todos['title'];
        model.description = todos['description'];
        model.category = todos['category'];
        model.todoDate = todos['todoDate'];
        model.isFinished = todos['isFinished'];
        _todoList.add(model);
      });
    });
  }

  /// Read theme from database and call themeFomDatabase in notifier class
  getAllThemes() async {
    _themeList = <DatabaseTheme>[];
    var themes = await _themeService.readTheme();
    themes.forEach((theme) {
      setState(() {
        var themeModel = DatabaseTheme();
        themeModel.kAppbarColor = theme['kAppbarColor'];
        themeModel.kAppbarText = theme['kAppbarText'];
        themeModel.kTextColor = theme['kTextColor'];
        themeModel.kBackgroundColor = theme['kBackgroundColor'];
        themeModel.kTileColor = theme['kTileColor'];
        themeModel.kTileText = theme['kTileText'];
        themeModel.kFloatColor = theme['kFloatColor'];
        themeModel.kFloatText = theme['kFloatText'];
        themeModel.kDrawerUpperText = theme['kDrawerUpperText'];
        themeModel.kDrawerLowerText = theme['kDrawerLowerText'];
        _themeList.add(themeModel);
        kAppbarColor = Color(_themeList[0].kAppbarColor);
        kAppbarText = Color(_themeList[0].kAppbarText);
        kTextColor = Color(_themeList[0].kTextColor);
        kBackgroundColor = Color(_themeList[0].kBackgroundColor);
        kTileColor = Color(_themeList[0].kTileColor);
        kTileText = Color(_themeList[0].kTileText);
        kFloatColor = Color(_themeList[0].kFloatColor);
        kFloatText = Color(_themeList[0].kFloatText);
        kDrawerUpperText = Color(_themeList[0].kDrawerUpperText);
        kDrawerLowerText = Color(_themeList[0].kDrawerLowerText);
      });
    });
    Provider.of<ThemeChanger>(context, listen: false).themeFromDatabase(
        kAppbarColor,
        kAppbarText,
        kTextColor,
        kBackgroundColor,
        kTileColor,
        kTileText,
        kFloatColor,
        kFloatText,
        kDrawerUpperText,
        kDrawerLowerText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeChanger>(context).kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color:
                Provider.of<ThemeChanger>(context, listen: false).kAppbarText),
        backgroundColor:
            Provider.of<ThemeChanger>(context, listen: false).kAppbarColor,
        title: Text(
          'TodoList using Sqlite',
          style: TextStyle(
              color: Provider.of<ThemeChanger>(context, listen: false)
                  .kAppbarText),
        ),
      ),
      drawer: const DrawerNavigation(),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Card(
                color: Provider.of<ThemeChanger>(context, listen: false)
                    .kTileColor,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _todoList[index].title ?? 'No Title',
                          style: TextStyle(
                              color: Provider.of<ThemeChanger>(context,
                                      listen: false)
                                  .kTileText),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      _todoList[index].category ?? 'No Category',
                      style: TextStyle(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTileText),
                    ),
                    trailing: Text(
                      _todoList[index].todoDate ?? 'No Date',
                      style: TextStyle(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTileText),
                    ),
                  ),
                  onLongPress: () {
                    var title = _todoList[index].title;
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        backgroundColor:
                            Provider.of<ThemeChanger>(context, listen: false)
                                .kBackgroundColor,
                        title: Text(
                          'Delete',
                          style: TextStyle(
                              color: Provider.of<ThemeChanger>(context,
                                      listen: false)
                                  .kTextColor),
                        ),
                        content: Text(
                            'Do you want to delete $title Permanently?',
                            style: TextStyle(
                                color: Provider.of<ThemeChanger>(context,
                                        listen: false)
                                    .kTextColor)),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'No'),
                            child: Text('No',
                                style: TextStyle(
                                    color: Provider.of<ThemeChanger>(context,
                                            listen: false)
                                        .kFloatColor)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'Yes');
                              // taskData.deleteTask(index);
                              _todoService.deleteTodo(_todoList[index].id);
                              setState(() {
                                getAllTodos();
                              });
                            },
                            child: Text('Yes',
                                style: TextStyle(
                                    color: Provider.of<ThemeChanger>(context,
                                            listen: false)
                                        .kFloatColor)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor:
              Provider.of<ThemeChanger>(context, listen: false).kFloatColor,
          child: Icon(
            Icons.add,
            color: Provider.of<ThemeChanger>(context, listen: false).kFloatText,
          ),
          onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TodoScreen()),
              )),
    );
  }
}
