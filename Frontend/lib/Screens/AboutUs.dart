import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:remedico/constants.dart';

class AboutUs extends StatefulWidget {
  static String id = "AboutUs";
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black54,
        title: Text('About Us'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image:AssetImage("images/app2.jpg"),
              fit: BoxFit.cover
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  color: Colors.white.withOpacity(0.7),
                  elevation: 10.0,
                  child: ListBody(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(left: 15.0, top: 15.0, bottom: 8.0),
                        child: Text(
                          "What is Remicure?",
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, top: 8.0, bottom: 15.0, right: 15.0),
                        child: Text(
                          "This application helps people treat some of the common diseases/injuries, by making home made remedies, whose ingredients are also easily available. It also helps people book an appointment to the doctor for some serious cases. There is also a community section, where there are various home remedies posted by the users, that can also be verified by doctors.",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  color: Colors.white.withOpacity(0.7),

                  elevation: 10.0,
                  child: ListBody(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(left: 15.0, top: 15.0, bottom: 8.0),
                        child: Text(
                          "Developed By:",
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0, left: 15.0),
                        child: Text(
                          "Parth Dua",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0, left: 15.0),
                        child: Text(
                          "Mrityunjay Mishra",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0, left: 15.0),
                        child: Text(
                          "Rachit Parwanda",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0, left: 15.0),
                        child: Text(
                          "Naman Jain",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  color: Colors.white.withOpacity(0.7),
                  elevation: 10.0,
                  child: ListBody(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(left: 15.0, top: 15.0, bottom: 8.0),
                        child: Text(
                          "Contact Us @",
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                        child: Text(
                          "Email : remicure4u@gmail.com",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
