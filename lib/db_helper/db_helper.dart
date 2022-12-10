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
  
  // Future<int> update(String id, String name, String family, String birthday,
  //     String mobile, String nationalId) async {
  //   var dbClient = await DBHelper.database();
  //   return await dbClient?.rawUpdate(
  //       'UPDATE $todo SET title = \'$name\', $FAMILY = \'$family\' ,$BIRTHDAY = \'$birthday\', $MOBILE = \'$mobile\' , $NATIONAL_ID = \'$nationalId\' WHERE $ID = ${int.parse(id)}');
  // }

  static Future upDate(
      String table, Map<String, Object?> values, String? myWhere,String id) async {
    Database? db = await DBHelper.database();
    int response = await db!.update(table, values, where: myWhere,whereArgs: [id]);
    // db.close();
    return response;
  }
}
