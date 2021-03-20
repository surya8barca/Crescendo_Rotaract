import 'package:flutter/material.dart';

class Trending extends StatefulWidget {
  final String address;
  Trending({this.address});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Trending> {
  String address;

  Future<void> gettrends() async {
    try {} catch (e) {
      print(e.toString());
      print("error");
    }
  }

  @override
  void initState() {
    address = widget.address;
    //gettreands();
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
                    'Trending',
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
