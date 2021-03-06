import 'package:animan_reader/thread_log_view.dart';
import 'package:animan_reader/web_view_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'animan reader',
      home: Home(key: key, url: 'https://bbs.animanch.com/'),
    );
  }
}

class Home extends StatelessWidget {
  final String url;

  const Home({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('WebView'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('スレッド閲覧履歴'),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ThreadLogView()));
                },
              )
            ],
          ),
        ),
        body: WebViewCore(key: key, url: url));
  }
}
