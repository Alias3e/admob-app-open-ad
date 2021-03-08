class AdMobTargetingInfo {
  final List<String>? keywords;
  final String? contentUrl;

  AdMobTargetingInfo({this.keywords, this.contentUrl});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (keywords != null) json['keywords'] = keywords;

    if (contentUrl != null) json['contentUrl'] = contentUrl;
    return json;
  }
}
