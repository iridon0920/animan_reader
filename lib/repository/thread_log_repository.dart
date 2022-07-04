import 'package:animan_reader/model/thread_log.dart';
import 'package:sqflite/sqflite.dart';

class ThreadLogRepository {
  final tableName = 'thread_log';
  final Database database;

  ThreadLogRepository(this.database);

  Future<void> save(ThreadLog threadLog) async {
    await database.insert(tableName, threadLog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ThreadLog>> find() async {
    final List<Map<String, dynamic>> list = await database.query(tableName);
    return List.generate(list.length, (i) {
      return ThreadLog(
          id: list[i]["id"],
          url: list[i]['url'],
          title: list[i]['title'],
          category: list[i]['category'],
          thumbnailData: list[i]['thumbnailData'],
          resCount: list[i]['resCount'],
          viewTime: list[i]['viewTime']);
    });
  }
}
