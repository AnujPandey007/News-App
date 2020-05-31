import 'package:flutter/foundation.dart';

class Article {
  String id;
  String thumbnail;
  String title;
  String description;
  String url;
  DateTime createdAt;

  Article({
    @required this.thumbnail,
    @required this.title,
    @required this.id,
    @required this.url,
    @required this.description,
    @required this.createdAt,
  });
}
