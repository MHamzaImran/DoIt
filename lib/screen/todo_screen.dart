import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_sqflite/services/category_service.dart';
import 'package:intl/intl.dart';
import 'package:todolist_sqflite/services/todo_services.dart';

import '../helpers/models/todo.dart';
import '../src/app.dart';
import 'homeScreen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _todoTitleController = TextEditingController();
  final _todoDescriptionController = TextEditingController();
  final _todoDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _categories = <DropdownMenuItem>[];
  var _selectedValues;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Provider.of<ThemeChanger>(context, listen: false)
                  .kAppbarColor,
              onPrimary:
                  Provider.of<ThemeChanger>(context, listen: false).kAppbarText,
              onSurface: Provider.of<ThemeChanger>(context, listen: false)
                  .kAppbarColor,
            ),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    primary: Provider.of<ThemeChanger>(context, listen: false)
                        .kAppbarText,
                    backgroundColor:
                        Provider.of<ThemeChanger>(context, listen: false)
                            .kAppbarColor)),
          ),
          child: child!,
        );
      },
    );

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
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
          'Create Task',
          style: TextStyle(
              color: Provider.of<ThemeChanger>(context, listen: false)
                  .kAppbarText),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Task Name Cannot be Empty";
                  } else if (!RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value)) {
                    return 'Task Name Should be alpha numeric';
                  } else {
                    return null;
                  }
                },
                cursorColor:
                    Provider.of<ThemeChanger>(context, listen: false).kFloatColor,
                style: TextStyle(
                    color: Provider.of<ThemeChanger>(context, listen: false)
                        .kTextColor),
                controller: _todoTitleController,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                    labelStyle: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                    fillColor: Provider.of<ThemeChanger>(context, listen: false)
                        .kFloatColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Provider.of<ThemeChanger>(context, listen: false)
                              .kTextColor),
                    ),
                    labelText: 'Title',
                    hintText: "Write Todo Title"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                cursorColor:
                    Provider.of<ThemeChanger>(context, listen: false).kFloatColor,
                style: TextStyle(
                    color: Provider.of<ThemeChanger>(context, listen: false)
                        .kTextColor),
                controller: _todoDescriptionController,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                    labelStyle: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Provider.of<ThemeChanger>(context, listen: false)
                              .kTextColor),
                    ),
                    labelText: 'Description',
                    hintText: "Write Todo Description"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                 if (!RegExp(r'^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$').hasMatch(value!)) {
                    return 'Date Format Should be yyyy-MM-dd';
                  } else {
                   return null;
                 }
                },
                cursorColor:
                    Provider.of<ThemeChanger>(context, listen: false).kFloatColor,
                style: TextStyle(
                    color: Provider.of<ThemeChanger>(context, listen: false)
                        .kTextColor),
                controller: _todoDateController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Provider.of<ThemeChanger>(context, listen: false)
                          .kTextColor),
                  labelStyle: TextStyle(
                      color: Provider.of<ThemeChanger>(context, listen: false)
                          .kTextColor),
                  prefixIconColor:
                      Provider.of<ThemeChanger>(context, listen: false)
                          .kTextColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                  ),
                  labelText: 'Date',
                  hintText: "Pick a date",
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectedTodoDate(context);
                    },
                    child: Icon(
                      Icons.calendar_today,
                      color: Provider.of<ThemeChanger>(context, listen: false)
                          .kTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<dynamic>(
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Provider.of<ThemeChanger>(context, listen: false)
                              .kTextColor),
                    ),
                    hintText: 'Choose Category',
                  ),
                  iconEnabledColor:
                      Provider.of<ThemeChanger>(context, listen: false)
                          .kTextColor,
                  style: TextStyle(
                      color: Provider.of<ThemeChanger>(context, listen: false)
                          .kTextColor),
                  focusColor: Provider.of<ThemeChanger>(context, listen: false)
                      .kTextColor,
                  dropdownColor: Provider.of<ThemeChanger>(context, listen: false)
                      .kBackgroundColor,
                  value: _selectedValues,
                  items: _categories,
                  onChanged: (value) {
                    setState(() {
                      _selectedValues = value;
                    });
                  }),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Provider.of<ThemeChanger>(context, listen: false)
                        .kFloatColor),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var todoObject = Todo();

                    todoObject.title = _todoTitleController.text;
                    todoObject.description = _todoDescriptionController.text;
                    todoObject.isFinished = 0;
                    todoObject.category = _selectedValues.toString();
                    todoObject.todoDate = _todoDateController.text;

                    var _todoService = TodoService();
                    await _todoService.saveTodo(todoObject);
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                    // print(result);
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Provider.of<ThemeChanger>(context, listen: false)
                          .kFloatText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
