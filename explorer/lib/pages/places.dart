import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:explorer/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:here_maps_webservice/here_maps_webservice.dart';
import 'package:http/http.dart';

class Places extends StatefulWidget {
  final LatLng coordinates;
  Places({this.coordinates});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Places> {
  HereMaps heremaps;
  List<dynamic> places = [];
  List<String> imageurls = [];
  List<dynamic> category = [];
  Future<void> famousplaces(LatLng argument) async {
    try {
      await heremaps
          .explorePopularPlaces(lat: argument.latitude, lon: argument.longitude)
          .then((value) async {
        setState(() {
          places.addAll(value['results']['items']);
        });
        await Future.forEach(places, (item) async {
          //https://serpapi.com/playground?q=pool&ijn=0&tbm=isch
          /*final response = await get(
              'https://serpapi.com/playground?q=${item['title']}&ijn=0&tbm=isch');
          var data = jsonDecode(response.body);
          print("*");
          print(data);*/
          if (item['category']['id'] != null &&
              item['category']['id'] != 'restaurant' &&
              !(category.contains(item['category']['id']))) {
            category.add(item['category']['id']);
          }
          if (item['category']['id'] == null ||
              item['category']['id'] == 'restaurant') {
            places.remove(item);
          }
        });
        print(category);
        print(places);
      });
    } catch (e) {
      print(e.toString());
      print("error");
    }
  }

  LatLng coordinates;

  @override
  void initState() {
    coordinates = widget.coordinates;
    heremaps = HereMaps(
        apiKey:
            "eb1nV17vXjOOaOd9HZsWFlde5SET0ncga8O-cg-AazI"); //create a new apikey
    famousplaces(widget.coordinates);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (places.length != 0) {
      return Scaffold(
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Places to Visit',
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
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
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
                                  places[index]['title'],
                                  maxLines: 2,
                                  minFontSize: 30,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                /*SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Image(
                                        image: NetworkImage(
                                            news[index]['urlToImage']))),*/
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
