import 'dart:convert';

import 'package:animan_reader/repository/thread_log_repository.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'model/thread_log.dart';

class AddThreadLogService {
  final ThreadLogRepository _threadLogRepository;

  AddThreadLogService(this._threadLogRepository);

  execute(String htmlBody, String url) async {
    final doc = parse(htmlBody);

    final threadLog = ThreadLog(
        url: url,
        title: _findTitle(doc),
        category: _findCategory(doc),
        thumbnailData: await _getThumbnailData(url),
        resCount: _findResCount(doc),
        viewTime: DateFormat('MM/dd hh:mm').format(DateTime.now()));
    print(threadLog.toMap().toString());
    await _threadLogRepository.save(threadLog);
  }

  _findTitle(Document doc) {
    return doc.getElementById('threadTitle')!.text;
  }

  _findCategory(Document doc) {
    final breadcrumb = doc.getElementById('breadcrumb')!.text;
    return breadcrumb.substring(
        breadcrumb.indexOf("『") + 1, breadcrumb.indexOf("』"));
  }

  Future<String> _getThumbnailData(String url) async {
    final thumbnailUrl = url.replaceFirst('board', 'thumb_s');
    final res = await get(Uri.parse(thumbnailUrl));
    return base64.encode(res.bodyBytes).toString();
  }

  _findResCount(Document doc) {
    final lastResId = doc.getElementById('resList')!.children.last.id;
    return int.parse(lastResId.substring(3));
  }
}
