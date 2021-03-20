import 'package:explorer/Placehome.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Explore extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Explore> {
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(20.5937, 78.9629),
    zoom: 5,
  );

  GoogleMapController _controller;

  Future<String> getaddress(LatLng argument) async {
    try {
      final address = await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(argument.latitude, argument.longitude));
      return address.first.addressLine;
    } catch (e) {
      print(e.message);
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          'Explore',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 25,
            color: Colors.black,
          ),
        ),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height / 72),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
                onLongPress: (argument) async {
                  final address = await getaddress(argument);
                  Alert(context: context,
                  title: address,
                  buttons: [],
                  style: AlertStyle(isCloseButton: false),
                  content: ButtonTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(
                                MediaQuery.of(context).size.width / 10.666)),
                        minWidth: MediaQuery.of(context).size.width / 2.1333,
                        height: MediaQuery.of(context).size.height / 8,
                        buttonColor: Colors.cyan,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaceHome(
                          address: address,
                        ),
                      ));
                          },
                          child: Text(
                            'View Place',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height / 21.333,
                            ),
                          ),
                        ),
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
        ),
      ),
    );
  }
}
