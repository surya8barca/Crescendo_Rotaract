import 'dart:async';

import 'package:explorer/Placehome.dart';
import 'package:explorer/explore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Future<LatLng> getcurrentlocation() async {
    try {
      var location = await _locationTracker.getLocation();
      return LatLng(location.latitude, location.longitude);
    } catch (e) {
      print(e.toString());
      print("error");
      return LatLng(20.5937, 78.9629);
    }
  }

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

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text(
          'Explorer',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 25,
            color: Colors.black,
          ),
        ),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ButtonTheme(
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
                              builder: (context) => Explore(),
                            ));
                      },
                      child: Text(
                        'Start exploring',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 21.333,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(
                            MediaQuery.of(context).size.width / 10.666)),
                    minWidth: MediaQuery.of(context).size.width / 2.1333,
                    height: MediaQuery.of(context).size.height / 8,
                    buttonColor: Colors.cyan,
                    child: ElevatedButton(
                      onPressed: () async {
                        LatLng location = await getcurrentlocation();
                        String address = await getaddress(location);
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlaceHome(
                                            address: address,coordinates: location,
                                          ),
                                        ));
                      },
                      child: Text(
                        'Around me',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 21.333,
                        ),
                      ),
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
