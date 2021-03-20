import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:explorer/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class News extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<News> {
  List news = [];
  Future<void> getnews() async {
    try {
      final response = await get(
          'https://newsapi.org/v2/top-headlines?country=in&apiKey=2ba0430718ce43b2ac991df4a33527d4');
      var data = jsonDecode(response.body);
      setState(() {
        news = data['articles'];
      });
      for (int i = 0; i < news.length; i++) {
        if (news[i]['urlToImage'] == null) {
          news.remove(news[i]);
        }
      }
    } catch (e) {
      print(e.toString());
      print("error");
    }
  }

  @override
  void initState() {
    getnews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (news.length != 0) {
      return Scaffold(
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Latest News',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: MediaQuery.of(context).size.width / 128,
                                color: Colors.blue),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                news[index]['title'],
                                maxLines: 3,
                                minFontSize: 30,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image(
                                      image: NetworkImage(
                                          news[index]['urlToImage']))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
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
