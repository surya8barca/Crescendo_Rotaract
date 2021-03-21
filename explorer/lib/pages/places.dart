import 'package:auto_size_text/auto_size_text.dart';
import 'package:explorer/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:here_maps_webservice/here_maps_webservice.dart';

class Places extends StatefulWidget {
  final LatLng coordinates;
  Places({this.coordinates});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Places> {
  HereMaps heremaps;
  List<dynamic> places = [];
  Future<void> famousplaces(LatLng argument) async {
    try {
      await heremaps
          .explorePopularPlaces(lat: argument.latitude, lon: argument.longitude)
          .then((value) async {
        setState(() {
          places.addAll(value['results']['items']);
        });
        await Future.forEach(places, (item) async {
          if (item['category']['id'] == null ||
              item['category']['id'] == 'restaurant') {
            places.remove(item);
          }
        });
        print(places);
      });
    } catch (e) {
      print(e.toString());
      print("error");
    }
  }

  bool visible = false;
  LatLng coordinates;
  int rating;
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
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
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
                              color: Colors.cyanAccent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width:
                                      MediaQuery.of(context).size.width / 128,
                                  color: Colors.blue),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: AutoSizeText(
                                    places[index]['title'],
                                    maxLines: 3,
                                    minFontSize: 25,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                ButtonTheme(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(25)),
                                  minWidth: MediaQuery.of(context).size.width /
                                      1.5,
                                  height:
                                      MediaQuery.of(context).size.height / 6,
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
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                28,
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
                                                  color: Colors.black,
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
