import 'package:animan_reader/main.dart';
import 'package:animan_reader/model/thread_log.dart';
import 'package:animan_reader/repository/database_core.dart';
import 'package:animan_reader/repository/thread_log_repository.dart';
import 'package:flutter/material.dart';

class ThreadLogView extends StatelessWidget {
  const ThreadLogView({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('スレッド閲覧履歴')),
        body: FutureBuilder(
          future: _getThreadLogs(),
          builder:
              (BuildContext ctx, AsyncSnapshot<List<ThreadLog>> dataSnapShot) {
            if (dataSnapShot.hasData) {
              return ListView(
                  children: dataSnapShot.data!
                      .map((threadLog) => LogItem(
                          threadTitle: threadLog.title,
                          category: threadLog.category,
                          time: threadLog.viewTime,
                          imagePath: 'https://bbs.animanch.com/thumb_s/758547/',
                          resCount: threadLog.resCount,
                          url: threadLog.url))
                      .toList());
            } else {
              return const Text("Loading...");
            }
          },
        ));
  }

  Future<List<ThreadLog>> _getThreadLogs() async {
    final repository = ThreadLogRepository((await DatabaseCore().database)!);
    return await repository.find();
  }
}

class LogItem extends StatelessWidget {
  final String threadTitle;
  final String category;
  final String time;
  final String imagePath;
  final int resCount;
  final String url;

  const LogItem(
      {Key? key,
      required this.threadTitle,
      required this.category,
      required this.time,
      required this.imagePath,
      required this.resCount,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        threadTitle,
        style: const TextStyle(fontSize: 14),
      ),
      subtitle: Text('$time $category'),
      leading: Image.network(imagePath),
      trailing: Text(
        resCount.toString(),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      url: url,
                    )));
      },
    );
  }
}
