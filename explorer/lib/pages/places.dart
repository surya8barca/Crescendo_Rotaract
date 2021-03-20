import 'package:explorer/shared/loading.dart';
import 'package:flutter/material.dart';
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
          .then((value) {
        print(value);
        setState(() {
          places.addAll(value['results']['items']);
        });
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
    heremaps = HereMaps(apiKey: "iFyx2NnmFuUfuw1X2Y6G690e9GhsbZ9SzrZyGSyo38A");//create a new apikey
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
                    return ListTile(
                      title: Text(places[index]['title']),
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
