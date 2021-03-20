import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:explorer/pages/news.dart';
import 'package:explorer/pages/places.dart';
import 'package:explorer/pages/restaurants.dart';
import 'package:explorer/pages/trends.dart';

class PlaceHome extends StatefulWidget {
  final String address;

  PlaceHome({this.address});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PlaceHome> {
  
  int pageindex = 0;
  List pages = [News(), Restaurants(), Places(), Trending()];
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: AutoSizeText(
          widget.address,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
          maxLines: 2,
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            pageindex = newIndex;
          });
        },
        children: [News(), Places(), Restaurants(), Trending()],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: pageindex,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(microseconds: 2),
              curve: Curves.linearToEaseOut);
          setState(() {
            pageindex = index;
          });
        },
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.black,
        height: 60,
        color: Colors.black,
        items: [
          Icon(
            Icons.article,
            color: Colors.blue,
            size: 40,
          ),
          Icon(
            Icons.festival,
            color: Colors.blue,
            size: 40,
          ),
          Icon(
            Icons.restaurant_menu,
            color: Colors.blue,
            size: 40,
          ),
          Icon(
            Icons.trending_up,
            color: Colors.blue,
            size: 40,
          )
        ],
      ),
    );
  }
}
