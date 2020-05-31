import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:newsapp/pages/details_page.dart';
import 'package:newsapp/pages/tabbar.dart';

import 'package:newsapp/providers/articles.dart';
import 'package:newsapp/providers/categories.dart';

class FlutterNewsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final articlesChangeNotifier = ChangeNotifierProvider.value(
      value: ArticlesProvider(),
    );
    final categoriesChangeNotifier = ChangeNotifierProvider.value(
      value: CategoriesProvider(),
    );
    return MultiProvider(
      providers: [
        articlesChangeNotifier,
        categoriesChangeNotifier,
      ],
      child: MaterialApp(
        title: 'Flutter News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        initialRoute: Tabbar.routeName,
        routes: {
          Tabbar.routeName: (ctx) => Tabbar(),
          DetailsPage.routeName: (ctx) => DetailsPage(),
        },
      ),
    );
  }
}

void main() {
  timeago.setLocaleMessages('en', timeago.EnMessages());
  return runApp(FlutterNewsApp());
}