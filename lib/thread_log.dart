import 'package:animan_reader/main.dart';
import 'package:flutter/material.dart';

class ThreadLog extends StatelessWidget {
  const ThreadLog({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('スレッド閲覧履歴')),
      body: ListView(
        children: const [
          LogItem(
              threadTitle: 'ニンダイに期待してることをあげてけ',
              category: 'その他ゲーム・ソシャゲ',
              time: '06/27 22:58',
              imagePath: 'https://bbs.animanch.com/thumb_s/758547/',
              resCount: '19',
              url: 'https://bbs.animanch.com/board/758547/')
        ],
      ),
    );
  }
}

class LogItem extends StatelessWidget {
  final String threadTitle;
  final String category;
  final String time;
  final String imagePath;
  final String resCount;
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
        resCount,
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
