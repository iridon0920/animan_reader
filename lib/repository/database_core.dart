import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCore {
  DatabaseCore._internal();
  static final _instance = DatabaseCore._internal();

  factory DatabaseCore() {
    return _instance;
  }

  Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    return openDatabase(join(await getDatabasesPath(), 'animan_database.db'),
        onCreate: (db, version) async {
      return await db.execute(
          "CREATE TABLE thread_log(id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, title TEXT, category TEXT, thumbnailData TEXT, resCount INTEGER, viewTime TEXT)");
    }, version: 1);
  }
}
