import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:explorer/pages/news.dart';
import 'package:explorer/pages/places.dart';
import 'package:explorer/pages/restaurants.dart';
import 'package:explorer/pages/trends.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceHome extends StatefulWidget {
  final String address;
  final LatLng coordinates;

  PlaceHome({this.address,this.coordinates});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PlaceHome> {
  int pageindex = 0;
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
        children: [News(), Places(coordinates: widget.coordinates,), Restaurants(coordinates: widget.coordinates,), Trending()],
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
