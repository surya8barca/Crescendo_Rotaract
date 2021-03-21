import 'package:auto_size_text/auto_size_text.dart';
import 'package:explorer/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:here_maps_webservice/here_maps_webservice.dart';

class Restaurants extends StatefulWidget {
  final LatLng coordinates;
  Restaurants({this.coordinates});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Restaurants> {
  HereMaps heremaps;
  List<dynamic> places = [];
  List<dynamic> restaurants = [];
  Future<void> famousplaces(LatLng argument) async {
    try {
      await heremaps
          .explorePopularPlaces(lat: argument.latitude, lon: argument.longitude)
          .then((value) {
        print(value);
        setState(() {
          places.addAll(value['results']['items']);
        });
        print(places);
        for (int i = 0; i < places.length; i++) {
          if (places[i]['category']['id'] != null &&
              places[i]['category']['id'] == 'restaurant') {
            restaurants.add(places[i]);
          }
        }
      });
    } catch (e) {
      print(e.toString());
      print("error");
    }
  }

  LatLng coordinates;
  bool visible = false;

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
    if (restaurants.length != 0) {
      return Scaffold(
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Restaurants',
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
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width:
                                      MediaQuery.of(context).size.width / 128,
                                  color: Colors.blue),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: AutoSizeText(
                                        restaurants[index]['title'],
                                        maxLines: 3,
                                        minFontSize: 25,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(
                            MediaQuery.of(context).size.width / 10.666)),
                    minWidth: MediaQuery.of(context).size.width / 2.1333,
                    height: MediaQuery.of(context).size.height / 8,
                    buttonColor: Colors.cyan,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                                        visible = true;
                                      });
                      },
                      child: Text(
                        'Rate this Place',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 28,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: visible,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        RatingBar.builder(
                                          itemCount: 5,
                                            itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.blue,
                                                ),
                                            onRatingUpdate: (rating) {
                                              setState(() {
                                                rating = rating;
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
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
                          SizedBox(height: 10,),
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
