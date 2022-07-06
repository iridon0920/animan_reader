import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:html/parser.dart';

void main() {
  group('HTML テスト', () {
    final testThread = File('${Directory.current.path}/test/test_thread.html')
        .readAsStringSync();
    final doc = parse(testThread);

    test("カテゴリー", () {
      final breadcrumb = doc.getElementById('breadcrumb')!.text;
      final category = breadcrumb.substring(
          breadcrumb.indexOf("『") + 1, breadcrumb.indexOf("』"));
      expect(category, "お知らせ");
    });

    test("レス数", () {
      final lastResId = doc.getElementById('resList')!.children.last.id;
      final resCount = int.parse(lastResId.substring(3));
      expect(resCount, 200);
    });
  });
}
