import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_sqflite/services/category_service.dart';
import '../helpers/models/category.dart';
import '../src/app.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _categoryNameController = TextEditingController();
  final _categoryDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _category = Category();
  final _categoryService = CategoryService();

  List<Category> _categoryList = <Category>[];

  var category = [];

  final _editCategoryNameController = TextEditingController();
  final _editCategoryDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    _categoryList = <Category>[];
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    var _category = await _categoryService.readCategoryById(categoryId);
    setState(
      () {
        _editCategoryNameController.text = _category['name'] ?? 'No Name';
        _editCategoryDescriptionController.text =
            _category['description'] ?? 'No Description';
      },
    );
    _editFormDialog(context, categoryId);
  }

  _showFormDialog(BuildContext context) {
    _categoryNameController.clear();
    _categoryDescriptionController.clear();
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          backgroundColor: Provider.of<ThemeChanger>(context, listen: false)
              .kBackgroundColor,
          title: Text(
            "Categories Form",
            style: TextStyle(
                color: Provider.of<ThemeChanger>(context, listen: false)
                    .kTextColor),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Category cannot be Empty";
                      } else if (!RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value)) {
                        return 'Category Should be alpha numeric';
                      } else {
                        return null;
                      }
                    },
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                      labelText: 'Write a Category',
                      hintText: 'Category',
                      labelStyle: TextStyle(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTextColor),
                      hintStyle: TextStyle(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTextColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Provider.of<ThemeChanger>(context,
                                    listen: false)
                                .kTextColor),
                      ),
                    ),
                    cursorColor:
                        Provider.of<ThemeChanger>(context, listen: false)
                            .kFloatColor,
                    style: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _categoryDescriptionController,
                    decoration: InputDecoration(
                      labelText: 'Write a Description',
                      hintText: 'Description',
                      labelStyle: TextStyle(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTextColor),
                      hintStyle: TextStyle(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTextColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Provider.of<ThemeChanger>(context,
                                    listen: false)
                                .kTextColor),
                      ),
                    ),
                    cursorColor:
                        Provider.of<ThemeChanger>(context, listen: false)
                            .kFloatColor,
                    style: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Provider.of<ThemeChanger>(context,
                                      listen: false)
                                  .kTileText),
                        ),
                        onPressed: () => Navigator.pop(context),
                        // color: Colors.white,
                      ),
                      TextButton(
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Provider.of<ThemeChanger>(context,
                                      listen: false)
                                  .kTileText),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _category.name = _categoryNameController.text;
                            _category.description =
                                _categoryDescriptionController.text;
                            await _categoryService.saveCategory(_category);
                            Navigator.pop(context);
                            getAllCategories();
                          }
                        },
                        // color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _editFormDialog(BuildContext context, [id]) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          backgroundColor: Provider.of<ThemeChanger>(context, listen: false)
              .kBackgroundColor,
          title: Text("Edit Categories",
              style: TextStyle(
                  color: Provider.of<ThemeChanger>(context, listen: false)
                      .kTextColor)),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Category cannot be Empty";
                      } else if (!RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value)) {
                        return 'Category Should be alpha numeric';
                      } else {
                        return null;
                      }
                    },
                    cursorColor: Provider.of<ThemeChanger>(context, listen: false)
                        .kAppbarColor,
                    style: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                    controller: _editCategoryNameController,
                    decoration: InputDecoration(
                      labelText: 'Write a Category',
                      hintText: 'Category',
                      labelStyle: TextStyle(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTextColor),
                      hintStyle: TextStyle(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTextColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Provider.of<ThemeChanger>(context,
                                    listen: false)
                                .kTextColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    cursorColor: Provider.of<ThemeChanger>(context, listen: false)
                        .kAppbarColor,
                    style: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                    controller: _editCategoryDescriptionController,
                    decoration: InputDecoration(
                      labelText: 'Write a Description',
                      hintText: 'Description',
                      labelStyle: TextStyle(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTextColor),
                      hintStyle: TextStyle(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTextColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Provider.of<ThemeChanger>(context,
                                    listen: false)
                                .kTextColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Provider.of<ThemeChanger>(context,
                                      listen: false)
                                  .kAppbarText),
                        ),
                        onPressed: () => Navigator.pop(context),
                        // color: Colors.white,
                      ),
                      TextButton(
                        child: Text(
                          'Update',
                          style: TextStyle(
                              color: Provider.of<ThemeChanger>(context,
                                      listen: false)
                                  .kAppbarText),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _category.id = id;
                            _category.name = _editCategoryNameController.text;
                            _category.description =
                                _editCategoryDescriptionController.text;
                            var result = await _categoryService
                                .updateCategory(_category);
                            if (result > 0) {
                              Navigator.pop(context);
                              getAllCategories();
                            }
                          }
                        },
                        // color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          backgroundColor: Provider.of<ThemeChanger>(context, listen: false)
              .kBackgroundColor,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Provider.of<ThemeChanger>(context, listen: false)
                        .kFloatColor),
              ),
            ),
            TextButton(
              onPressed: () async {
                var result = await _categoryService.deleteCategory(categoryId);
                if (result > 0) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CategoriesScreen()));
                  getAllCategories();
                }
              },
              child: Text(
                'Delete',
                style: TextStyle(
                    color: Provider.of<ThemeChanger>(context, listen: false)
                        .kFloatColor),
              ),
            ),
          ],
          title: Text("Are you sure you want to delete this?",
              style: TextStyle(
                  color: Provider.of<ThemeChanger>(context, listen: false)
                      .kDrawerLowerText)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeChanger>(context, listen: false).kBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            Provider.of<ThemeChanger>(context, listen: false).kAppbarColor,
        iconTheme: IconThemeData(
          color: Provider.of<ThemeChanger>(context, listen: false).kAppbarText,
        ),
        title: Text(
          'Categories',
          style: TextStyle(
              color: Provider.of<ThemeChanger>(context, listen: false)
                  .kAppbarText),
        ),
      ),
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            child: Card(
              color:
                  Provider.of<ThemeChanger>(context, listen: false).kTileColor,
              elevation: 8.0,
              child: ListTile(
                leading: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Provider.of<ThemeChanger>(context, listen: false)
                        .kTileText,
                  ),
                  onPressed: () {
                    _editCategory(context, _categoryList[index].id);
                  },
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _categoryList[index].name,
                      style: TextStyle(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTileText),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteFormDialog(context, _categoryList[index].id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTileText,
                      ),
                    )
                  ],
                ),
                subtitle: Text(_categoryList[index].description,
                    style: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTileText)),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            Provider.of<ThemeChanger>(context, listen: false).kFloatColor,
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Provider.of<ThemeChanger>(context, listen: false).kFloatText,
        ),
      ),
    );
  }
}
