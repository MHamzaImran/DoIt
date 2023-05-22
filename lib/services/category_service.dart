import 'package:todolist_sqflite/helpers/models/category.dart';
import 'package:todolist_sqflite/helpers/models/repositories/repository.dart';

class CategoryService {
  final Repository _repository = Repository();

  saveCategory(Category category) async {
    var result =
        await _repository.insertData('categories', category.categoryMap());
    return result;
  }

  readCategories() async {
    return await _repository.readData('categories');
  }

  readCategoryById(categoryId) async {
    var result = await _repository.readDataById('categories', categoryId);
    return result;
  }

  updateCategory(Category category) async {
    var result =
        await _repository.updateData('categories', category.categoryMap());
    return result;
  }

  deleteCategory(categoryId) async {
    return await _repository.deleteData('categories', categoryId);
  }
  saveTheme(Category category) async {
    var result =
    await _repository.insertThemeData('categories', category.categoryMap());
    return result;
  }

}
