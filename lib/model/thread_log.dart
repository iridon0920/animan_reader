class ThreadLog {
  final int? id;
  final String url;
  final String title;
  final String category;
  final String thumbnailData;
  final int resCount;
  final String viewTime;

  ThreadLog(
      {this.id,
      required this.url,
      required this.title,
      required this.category,
      required this.thumbnailData,
      required this.resCount,
      required this.viewTime});

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'title': title,
      'category': category,
      'thumbnailData': thumbnailData,
      'resCount': resCount,
      'viewTime': viewTime,
    };
  }
}
