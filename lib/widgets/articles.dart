import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'dart:math' as Math;

import 'package:newsapp/providers/articles.dart';
import 'package:newsapp/providers/categories.dart';

import 'package:newsapp/widgets/article_card_item.dart';

import 'package:newsapp/pages/details_page.dart';
import 'package:newsapp/models/article.dart';

class Articles extends StatefulWidget {
  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  final _headlinesCount = 3;
  Map<String, Future<List<Article>>> _articlesFutures = {};

  void _readArticle(BuildContext context, String id) {
    Navigator.of(context).pushNamed(DetailsPage.routeName, arguments: id);
  }

  Widget _buildArticlesList({
    List<Article> data,
    Function onPressed,
    Function onLongPress,
  }) {
    var articles = data;
    print('DATA: '+data.length.toString());
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: articles.length,
        itemBuilder: (_, index) {
          var cardItem = articles[index];
          return Container(
            child: ArticleCardItem(
              id: cardItem.id,
              title: cardItem.title,
              image: cardItem.thumbnail,
              url: cardItem.url,
              desc: cardItem.description,
              onPress: onPressed,
              date: cardItem.createdAt,
            ),
          );
        });
  }

  Future<List<Article>> _buildArticlesFuture(String categoryId) {
    print('At: 1 -- '+categoryId);
    print('At: 2 -- '+_articlesFutures[categoryId].toString());
    if (_articlesFutures[categoryId] != null) {
      return _articlesFutures[categoryId];
    }

    var articlesProvider = Provider.of<ArticlesProvider>(context);
    var articlesFuture = articlesProvider.fetchArticles(categoryId);
    _articlesFutures[categoryId] = articlesFuture;
    return articlesFuture;
  }

  @override
  Widget build(BuildContext context) {
    var articlesProvider = Provider.of<ArticlesProvider>(context);
    var categoriesProvider = Provider.of<CategoriesProvider>(context);
    if (categoriesProvider.currentCategory == null) {
      return CircularProgressIndicator();
    }

    return FutureBuilder(
      future: _buildArticlesFuture(categoriesProvider.currentCategory.url),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? CircularProgressIndicator()
              : snapshot.hasError
                  ? Text(snapshot.error)
                  : Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildArticlesList(
                              data: snapshot.data,
                              onPressed: (id) => _readArticle(ctx, id),
                              ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
    );
  }
}
