import 'package:flutter/material.dart';

class ThreadLog extends StatelessWidget {
  const ThreadLog({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('スレッド閲覧履歴')),
      body: ListView(
        children: const [
          ListTile(
            title: Text('1'),
          )
        ],
      ),
    );
  }
}
