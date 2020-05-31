import 'package:flutter/material.dart';

import 'package:newsapp/models/article_category.dart';

class CategoriesProvider extends ChangeNotifier {
//  List<ArticleCategory> _categories;
  List<ArticleCategory> _allCategories = [
    ArticleCategory(
        id: 0,
        name: "Google News",
        url: "google-news"
    ),
    ArticleCategory(
        id: 1,
        name: "Bloomberg",
        url: "bloomberg"
    ),
    ArticleCategory(
        id: 2,
        name: "Buzzfeed",
        url: "buzzfeed"
    ),
    ArticleCategory(
        id: 3,
        name: "CBC News",
        url: "cbc-news"
    ),
    ArticleCategory(
        id: 4,
        name: "CNN",
        url: "cnn"
    ),
    ArticleCategory(
        id: 5,
        name: "ABC News",
        url: "abc-news"
    ),
    ArticleCategory(
        id: 6,
        name: "National Geographic",
        url: "national-geographic"
    ),
    ArticleCategory(
        id: 7,
        name: "NBC News",
        url: "nbc-news"
    ),
    ArticleCategory(
        id: 8,
        name: "Reuters",
        url: "reuters"
    ),
    ArticleCategory(
        id: 9,
        name: "The Huffington Post",
        url: "the-huffington-post"
    ),
  ];

  var _categoriesDisplayCount = 10;
  int _selectedCategoryId = 0;

  Future<List<ArticleCategory>> fetchAllCategories() async {
    try {
//      if(_categories == null)
//        _categories = [..._allCategories];
//      else
//        _categories.addAll(_allCategories);
      if (_selectedCategoryId == null) {
        print('Here: '+_selectedCategoryId.toString());
//        _selectedCategoryId = categories.first.id;
//        notifyListeners();
        selectCategory(_allCategories.first.id);
      }
      return Future.value(_allCategories);
    } catch (e) {
      return Future.error('An error occured');
    }
  }


  void selectCategory(int id) {
    print('II: '+id.toString());
    _selectedCategoryId = id;
    notifyListeners();
  }

  List<ArticleCategory> get categories => _allCategories != null
      ? _allCategories.take(_categoriesDisplayCount).toList()
      : [];

  List<ArticleCategory> get allCategories => _allCategories ?? [];

  ArticleCategory get currentCategory =>
      _selectedCategoryId == null ? null : findById(_selectedCategoryId);

  ArticleCategory findById(int id) => id == null
      ? null
      : categories.firstWhere((category) => category.id == id);

  bool isSelected(ArticleCategory category) =>
      category.id == _selectedCategoryId;
}
