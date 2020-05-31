import 'package:flutter/material.dart';
import 'package:newsapp/providers/categories.dart';
import 'package:provider/provider.dart';

import 'package:newsapp/widgets/articles.dart';
import 'package:newsapp/widgets/categories.dart';

import 'package:newsapp/providers/articles.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    var articlesProvider = Provider.of<ArticlesProvider>(
      context,
      listen: false,
    );
//    final categoriesProvider =
//    Provider.of<CategoriesProvider>(context, listen: false);
//    categoriesProvider.fetchAllCategories();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'News App Internship',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: articlesProvider.refresh,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Categories(),
              Articles(),
            ],
          ),
        ),
      ),
    );
  }
}
