import 'package:animan_reader/thread_log.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'animan reader',
      home: Home(key),
    );
  }
}

class Home extends StatelessWidget {
  const Home(key) : super(key: key);

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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ThreadLog()));
              },
            )
          ],
        ),
      ),
      body: const WebView(
          initialUrl: 'https://bbs.animanch.com/',
          javascriptMode: JavascriptMode.unrestricted),
    );
  }
}
