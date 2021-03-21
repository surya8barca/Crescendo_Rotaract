import 'package:auto_size_text/auto_size_text.dart';
import 'package:explorer/Placehome.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:here_maps_webservice/here_maps_webservice.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Explore extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Explore> {
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(20.5937, 78.9629),
    zoom: 4,
  );

  GoogleMapController _controller;

  Future<String> getaddress(LatLng argument) async {
    try {
      final address = await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(argument.latitude, argument.longitude));
      return address.first.addressLine;
    } catch (e) {
      print(e.message.toString());
      return "Error";
    }
  }

  TextEditingController txt2 = new TextEditingController();
  HereMaps heremaps;
  List autocomplete = [];


  @override
  void initState() {
    heremaps = HereMaps(apiKey: "eb1nV17vXjOOaOd9HZsWFlde5SET0ncga8O-cg-AazI");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Explore',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Long press the place you want to explore',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 25,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: MediaQuery.of(context).size.width / 128,
                        color: Colors.black),
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                      onLongPress: (argument) async {
                        final address = await getaddress(argument);
                        Alert(
                          context: context,
                          title: address,
                          buttons: [],
                          style: AlertStyle(isCloseButton: false,backgroundColor: Colors.transparent,titleStyle: TextStyle(color: Colors.white)),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              ButtonTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(25)),
                                minWidth:
                                    MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 4,
                                buttonColor: Colors.cyan,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlaceHome(
                                            address: address,
                                            coordinates: argument,
                                          ),
                                        ));
                                  },
                                  child: Text(
                                    'View Place',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              21.333,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).show();
                      },
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      minMaxZoomPreference: MinMaxZoomPreference(3, 8),
                      mapType: MapType.normal,
                      initialCameraPosition: initialLocation,
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      compassEnabled: true,
                      gestureRecognizers: Set()
                        ..add(Factory<PanGestureRecognizer>(
                            () => PanGestureRecognizer()))
                        ..add(Factory<ScaleGestureRecognizer>(
                            () => ScaleGestureRecognizer()))
                        ..add(Factory<VerticalDragGestureRecognizer>(
                            () => VerticalDragGestureRecognizer()))
                        ..add(Factory<HorizontalDragGestureRecognizer>(
                            () => HorizontalDragGestureRecognizer()))
                        ..add(Factory<EagerGestureRecognizer>(
                            () => EagerGestureRecognizer()))),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
