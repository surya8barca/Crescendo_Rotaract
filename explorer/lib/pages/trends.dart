import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:explorer/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Trending extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Trending> {
  List trends = [];
  String url = 'https://tends-api.herokuapp.com/get_trends';

  Future<void> gettrends() async {
    try {
      List values = [];
      final response = await get(url);
      var data = jsonDecode(response.body);
      for (int i = 0; i < 20; i++) {
        values.add(data['0']['$i']);
      }
      setState(() {
        trends = values;
      });
    } catch (e) {
      print(e.toString());
      print("error");
    }
  }

  @override
  void initState() {
    gettrends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (trends.length != 0) {
      return Scaffold(
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Trending topics',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: trends.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width:
                                      MediaQuery.of(context).size.width / 128,
                                  color: Colors.black),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AutoSizeText(
                                  "#${index+1}  ${trends[index]}",
                                  maxLines: 2,
                                  minFontSize: 30,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Loading();
    }
  }
}
