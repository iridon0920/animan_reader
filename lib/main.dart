import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'animan reader',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('WebView'),
          ),
          body: const WebView(
              initialUrl: 'https://bbs.animanch.com/',
              javascriptMode: JavascriptMode.unrestricted),
        ));
  }
}
