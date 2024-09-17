import 'dart:convert';

import 'package:sa/models/xarajat.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class XarajatSql {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  // Initialize the database
  static Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'monex.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE xarajatlar(
            id TEXT,
            summa REAL,
            category TEXT,
            date TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertXarajat(Xarajat xarajat) async {
    final db = await database;
    return await db.insert(
      'xarajatlar',
      xarajat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// Fetch all xarajats
  Future<List> fetchXarajatlar() async {
    final db = await database;
    final List maps = await db.query('xarajatlar');
    // print(maps);
    List<Xarajat> xarajatlar = List.generate(maps.length, (i) {
      // print("${maps[i]} $i");
      Xarajat xarajat = Xarajat.fromMap(maps[i]);
      return xarajat;
    });
    return xarajatlar;
  }

  // Delete a Xarajat from the database
  Future<int> deleteTodo(String id) async {
    final db = await database;
    return await db.delete(
      'xarajatlar',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
