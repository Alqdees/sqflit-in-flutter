import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  void updateData(
      TextEditingController title,
      TextEditingController description,
      TextEditingController date,
      String id,
      BuildContext context) async {
    int response = await DBHelper.upDate(
        DBHelper.todo,
        {
          "title": title.text,
          "description": description.text,
          "date": date.text,
        },
        "ID = $id}",
        id);
    if (response > 0) {
      Fluttertoast.showToast(
        msg: "تمت التحديث",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.greenAccent,
        fontSize: 22,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.black,
      );
    }
    notifyListeners();
  }
}
