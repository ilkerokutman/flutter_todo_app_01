import 'dart:io';

import 'package:flutter_todo_app_01/core/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  DbProvider._();
  static final DbProvider db = DbProvider._();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return await openDatabase(path, singleInstance: true, version: databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute(dropTodoTable);
      await db.execute(createTodoTable);
    });
  }

  Future<int> insert({required Map<String, dynamic> data}) async {
    try {
      final db = await database;
      if (db == null) return -1;
      int id = await db.insert(toDoTable, data, conflictAlgorithm: ConflictAlgorithm.replace);
      return id;
    } catch (error) {
      return -1;
    }
  }

  Future<int> delete({required String where, required String args}) async {
    final db = await database;
    if (db == null) return -1;
    return await db.delete(toDoTable, where: where, whereArgs: [args]);
  }

  Future<int> update({required Map<String, dynamic> data, required String where, required String args}) async {
    try {
      final db = await database;
      if (db == null) return -1;
      int id = await db.update(toDoTable, data, where: where, whereArgs: [args]);
      return id;
    } catch (error) {
      return -1;
    }
  }

  Future<Map<String, dynamic>?> getRow({required String where, required String args}) async {
    final db = await database;
    if (db == null) return null;
    try {
      var result = await db.query(toDoTable, where: where, whereArgs: [args], orderBy: "id DESC", limit: 1);
      if (result.isNotEmpty) {
        Map<String, dynamic> row = result.first;
        return row;
      }
    } catch (error) {
      return null;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getRows({String? where, String? args}) async {
    List<Map<String, dynamic>> rows = <Map<String, dynamic>>[];
    final db = await database;
    if (db == null) return rows;
    try {
      var result = where == null || args == null
          ? await db.query(toDoTable, orderBy: "id DESC")
          : await db.query(toDoTable, where: where, whereArgs: [args], orderBy: "id DESC");

      if (result.isNotEmpty) {
        for (var i = 0; i < result.length; i++) {
          rows.add(result[i]);
        }
      }
    } catch (error) {
      return rows;
    }
    return rows;
  }
}
