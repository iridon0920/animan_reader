import 'dart:async';

import 'package:animan_reader/add_thread_log_service.dart';
import 'package:animan_reader/repository/database_core.dart';
import 'package:animan_reader/repository/thread_log_repository.dart';
import 'package:flutter/material.dart';
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
            onMessageReceived: (result) async {
              if (url.contains('board')) {
                final repository =
                    ThreadLogRepository((await DatabaseCore().database)!);
                final service = AddThreadLogService(repository);
                await service.execute(result.message, url);
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
