import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_sqflite/services/todo_services.dart';

import '../helpers/models/todo.dart';
import '../src/app.dart';

class TodosByCategory extends StatefulWidget {
  const TodosByCategory({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  _TodosByCategoryState createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {
  final List<Todo> _todoList = <Todo>[];
  final TodoService _todoService = TodoService();

  @override
  void initState() {
    super.initState();
    getTodosCategories();
  }

  getTodosCategories() async {
    var todos = await _todoService.readTodosByCategory(widget.category);
    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.title = todo['title'];
        model.description = todo['description'];
        model.todoDate = todo['todoDate'];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:
          Provider.of<ThemeChanger>(context, listen: false).kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color:
            Provider.of<ThemeChanger>(context, listen: false).kAppbarText),
        backgroundColor:
            Provider.of<ThemeChanger>(context, listen: false).kAppbarColor,
        title: Text(
          widget.category,
          style: TextStyle(
              color: Provider.of<ThemeChanger>(context, listen: false)
                  .kAppbarText),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    elevation: 8,
                    child: ListTile(
                      tileColor:
                          Provider.of<ThemeChanger>(context, listen: false)
                              .kTileColor,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _todoList[index].title,
                            style: TextStyle(
                                color: Provider.of<ThemeChanger>(context,
                                        listen: false)
                                    .kTileText),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        _todoList[index].description,
                        style: TextStyle(
                            color: Provider.of<ThemeChanger>(context,
                                    listen: false)
                                .kTileText),
                      ),
                      trailing: Text(
                        _todoList[index].todoDate,
                        style: TextStyle(
                            color: Provider.of<ThemeChanger>(context,
                                    listen: false)
                                .kTileText),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
