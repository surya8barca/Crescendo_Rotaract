import 'package:flutter/material.dart';

class News extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
          'News',
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.black,
          ),
        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
