import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const todo = 'todo';
  static Future<Database?> database() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'todo.db'),
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE IF NOT EXISTS $todo(id TEXT PRIMARY KEY , title TEXT , description TEXT,date TEXT )");
      },
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>?>?> selectAll(String table) async {
    final db = await DBHelper.database();
    return db?.query(table);
  }

  static Future insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    return db!.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
