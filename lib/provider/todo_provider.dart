import 'package:flutter/foundation.dart';
import 'package:sqflite_curd/db_helper/db_helper.dart';
import 'package:uuid/uuid.dart';

import '../model/todoModel.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> todoItem = [];

  Future<void> selectData() async {
    final dataList = await DBHelper.selectAll(DBHelper.todo);
    todoItem = dataList!
        .map(
          (items) => TodoModel(
            id: items!["id"],
            title: items["title"],
            description: items["description"],
            date: items['date'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future insertData(String title, String description, String date) async {
    final newTodo = TodoModel(
      id: const Uuid().v1(),
      title: title,
      description: description,
      date: date,
    );
    todoItem.add(newTodo);
    DBHelper.insert(
      DBHelper.todo,
      {
        'id': newTodo.id,
        'title': newTodo.title,
        'description': newTodo.description,
        'date': newTodo.date,
      },
    );
    notifyListeners();
  }
}
