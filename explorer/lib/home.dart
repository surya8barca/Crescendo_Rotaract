import 'package:explorer/explore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text(
          'Explorer',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height/25,
            color: Colors.black,
          ),
        ),
      ),
      body: Builder(builder: (context) => 
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
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
                                  fontSize:
                                      MediaQuery.of(context).size.height / 21.333,
                                ),
                              ),
                            ),
                          ),
              ),
                        SizedBox(height: 10,),
                        Center(
                          child: ButtonTheme(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 10.666)),
                            minWidth: MediaQuery.of(context).size.width / 2.1333,
                            height: MediaQuery.of(context).size.height / 8,
                            buttonColor: Colors.cyan,
                            child: ElevatedButton(
                              onPressed: () {/*
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Explore(),
                                    ));*/
                              },
                              child: Text(
                                'Around me',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 21.333,
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