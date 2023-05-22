import 'package:todolist_sqflite/helpers/models/repositories/repository.dart';
import '../helpers/models/todo.dart';

class TodoService {
  final Repository _repository = Repository();

  saveTodo(Todo todo) async {
    var result = await _repository.insertData('todos', todo.todoMap());
    return result;
  }

  readTodo() async {
    var result = await _repository.readData('todos');
    return result;
  }

  readTodosByCategory(category) async {
    var result =
        await _repository.readDataByColumnName('todos', 'category', category);
    return result;
  }

  deleteTodo(itemId) async {
    var result = await _repository.deleteData('todos', itemId);
    return result;
  }
}
