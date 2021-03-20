import 'package:flutter/material.dart';

class Places extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Places> {
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
          'Places to Visit',
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
