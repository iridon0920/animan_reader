import 'dart:async';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCore extends StatelessWidget {
  final String url;
  final _controller = Completer<WebViewController>();

  WebViewCore({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (webViewController) {
        _controller.complete(webViewController);
      },
      javascriptChannels: {
        JavascriptChannel(
            name: 'fl_get_html',
            onMessageReceived: (result) {
              final document = parse(result.message);
              final element = document.getElementById('threadTitle');
              print(element);
              if (element != null) {
                print(element.text);
              }
            }),
      },
      onPageFinished: (String url) async {
        final controller = await _controller.future;
        print('ページ読み込み完了: $url');

        controller.runJavascript("""
                fl_get_html.postMessage(document.querySelectorAll('html')[0].outerHTML)
            """);
      },
    );
  }
}
