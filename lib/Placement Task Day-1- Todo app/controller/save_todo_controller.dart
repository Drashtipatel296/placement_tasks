import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/todo_model.dart';

class SaveTodoController extends GetxController {
  RxList<TodoModel> saveTodo = <TodoModel>[].obs;


  Future<void> saveTodos(TodoModel todo) async {
    final data = await SharedPreferences.getInstance();
    if (!saveTodo.any((item) => item.id == todo.id)) {
      saveTodo.add(todo);
    }
    final saveList = saveTodo.map((e) => jsonEncode(e.toJson())).toList();
    await data.setStringList('savedTodos', saveList);
  }

  Future<void> loadSaveTodo() async {
    final data = await SharedPreferences.getInstance();
    final saveList = data.getStringList('savedTodo') ?? [];
    saveTodo.value =
        saveList.map((e) => TodoModel.fromJson(json.decode(e))).toList();
  }

  Future<void> toggleBookmark(TodoModel todo) async {
    final data = await SharedPreferences.getInstance();
    if (saveTodo.any((item) => item.id == todo.id)) {
      saveTodo.removeWhere((item) => item.id == todo.id);
    } else {
      saveTodo.add(todo);
    }
    final saveList = saveTodo.map((e) => json.encode(e.toJson())).toList();
    await data.setStringList('savedTodos', saveList);
  }

  Future<void> removeTodo(TodoModel todo) async {
    final data = await SharedPreferences.getInstance();
    saveTodo.removeWhere((item) => item.id == todo.id);
    final saveList = saveTodo.map((e) => json.encode(e.toJson())).toList();
    await data.setStringList('savedTodos', saveList);
  }
}