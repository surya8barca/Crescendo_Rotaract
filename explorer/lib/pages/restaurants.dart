import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Restaurants extends StatefulWidget {
  final LatLng coordinates;
  Restaurants({this.coordinates});
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
