import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";

import 'package:goal_app/Feature/Pages/model/goal_data.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'goals_app.db'); 
    Database myDb = await openDatabase(path, onCreate: _onCreate, version: 1);
    return myDb;
  }


  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "goals" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
        "title" TEXT NOT NULL,
        "isDone" INTEGER NOT NULL,
        "date" TEXT NOT NULL
      )
    ''');
    print("Create Database & Table Success ===================");
  }

  Future<List<Goal>> readData() async {
    Database? myDb = await db;
    List<Map<String, dynamic>> response = await myDb!.query("goals");

    return response.map((e) => Goal.fromMap(e)).toList();
  }

  Future<int> insertData(Goal goal) async {
    Database? myDb = await db;
    int response = await myDb!.insert("goals", goal.toMap());
    return response;
  }


  Future<int> updateData(Goal goal) async {
    Database? myDb = await db;
    int response = await myDb!.update(
      "goals", 
      goal.toMap(), 
      where: 'id = ?', 
      whereArgs: [goal.id]
    );
    return response;
  }


  Future<int> deleteData(int id) async {
    Database? myDb = await db;
    int response = await myDb!.delete("goals", where: 'id = ?', whereArgs: [id]);
    return response;
  }
}