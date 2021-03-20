import 'package:flutter/material.dart';

class Restaurants extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Restaurants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
          'Restaurants',
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.black,
          ),
        ),
                ),
              ],
            ),),
        ),
      ),
    );
  }
}
