import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:newsapp/models/article.dart';
import 'package:newsapp/constants.dart';

class ArticlesProvider with ChangeNotifier {
  final _pageSize = 20;
  int _page;
  String _categoryId;

  List<Article> _articles = [];

  Future<List<Article>> fetchArticles(String categoryId, [int page = 1]) async {
    _page = page;
    print('Si - 0: '+_articles.length.toString());
    if (categoryId != _categoryId) {
      _categoryId = categoryId;
      _articles.clear();
    }
    final url =
        '${Constants['API_BASE_URL']}/top-headlines?sources=$categoryId&apiKey=${Constants['API_KEY']}';
//    print(url);
    try {
      var response = await http.get(url);
      var data = json.decode(response.body);
      _articles.addAll(_formatArticle(data['articles'], categoryId));
      notifyListeners();
      print('Si: '+_articles.length.toString());
      return Future.value(_articles);
    } catch (e) {
      return Future.error('An error occured');
    }
  }

  Future<void> refresh() async {
    _articles.clear();
    notifyListeners();
    await fetchArticles(_categoryId, 1);
  }

  Future<void> nextPage() async {
    await fetchArticles(_categoryId, _page + 1);
  }

  Article findById(String id) =>
      this._articles.firstWhere((article) => article.url == id);

  List<Article> _formatArticle(List<dynamic> jsonData, String categoryId) {
    return jsonData.map((json) {

//      String articleId = categoryId+_articles.length.toString();
      return Article(
        id: categoryId,
        thumbnail: json['urlToImage'] == null? '': json['urlToImage'],
        url: json['url'],
        title: json['title'],
        description: json['description'],
        createdAt: DateTime.parse(json['publishedAt']),
      );
    }).toList();
  }

  List<Article> get articles => [..._articles];
}
