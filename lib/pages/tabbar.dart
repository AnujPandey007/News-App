import 'package:flutter/material.dart';

import 'package:newsapp/pages/home_page.dart';

class Tabbar extends StatefulWidget {
  static final routeName = '/';
  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
//  var _currentIndex = 0;
//
//  final List<Widget> _children = [
//    HomePage(),
//    FavoritesPage(),
//    BookmarksPage(),
//  ];
//
//  void onTabTapped(int index) {
//    setState(() {
//      _currentIndex = index;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
    );
  }
}
