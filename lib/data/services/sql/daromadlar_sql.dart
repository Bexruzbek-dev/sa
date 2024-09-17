import 'package:sa/models/daromad.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DaromadSql {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  // Initialize the database
  static Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'salom.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE daromadlar(
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

  Future<int> insertDaromad(Daromad daromad) async {
    final db = await database;
    return await db.insert(
      'daromadlar',
      daromad.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// Fetch all daromads
  Future<List> fetchDaromadlar() async {
    final db = await database;
    final List maps = await db.query('daromadlar');
    // print(maps);
    List<Daromad> daromadlar = List.generate(maps.length, (i) {
      // print("${maps[i]} $i");
      Daromad daromad = Daromad.fromMap(maps[i]);
      return daromad;
    });
    return daromadlar;
  }

  // Delete a Daromad from the database
  Future<int> deleteTodo(String id) async {
    final db = await database;
    return await db.delete(
      'daromadlar',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
