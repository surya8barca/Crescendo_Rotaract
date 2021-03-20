import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

class Places extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Places> {
  GooglePlace gplace;

  @override
  void initState() {
    gplace = GooglePlace("AIzaSyA-Uz5RbrcKJz1c31VAIRc-fdIOvDUk3pA");
    super.initState();
  }

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
