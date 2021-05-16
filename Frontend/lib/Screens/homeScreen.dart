import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:remedico/Components/reusableCard.dart';
import 'package:remedico/Screens/AboutUs.dart';
import 'package:remedico/Screens/Appointment.dart';
import 'package:remedico/Screens/community.dart';
import 'package:remedico/Screens/homeRemedy.dart';
import 'package:remedico/constants.dart';

class HomeScreen extends StatefulWidget {
  static String id = "HomeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  final List<String> _image = [
    'images/img1.png',
    'images/img2.png',
    'images/img3.jpg',
    'images/img4.jpg',
    'images/img5.png'
  ];
  double _scale;
  AnimationController _controller;

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.black54,
        backgroundColor: Colors.black54,
        title: Text("REMICURE"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black54),
              child: Text(
                '${_auth.currentUser.email}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('EMAIL'),
              subtitle: Text('${_auth.currentUser.email}'),
            ),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pushNamed(context, 'setting');
                }),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Logout'),
              onTap: () async {
                _auth.signOut();
                Navigator.popUntil(context, ModalRoute.withName('signup'));
              },
            ),
          ],
        ),
      ),
      backgroundColor: Background,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/app11.jpg"), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          // filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: 300,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: _image.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          child: Image.asset(imagePath),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _image.map((imagepath) {
                  int index = _image.indexOf(imagepath);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        _controller.forward();
                        _controller.reverse();
                        Navigator.pushNamed(context, HomeRemedy.id);
                      },
                      onTapUp: _tapUp,
                      child: Transform.scale(
                        scale: _scale,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 150.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.medical_services_rounded,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "HOME",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "REMEDIES",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: colour,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   //HOME REMEDY
                  //   child: ReusableCard(
                  //     height: 150.0,
                  //     colour: colour,
                  //     onPress: () {
                  //       Navigator.pushNamed(context, HomeRemedy.id);
                  //     },
                  //     cardChild: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Center(
                  //             child: Icon(
                  //               Icons.medical_services_rounded,
                  //               size: 60,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           Center(
                  //             child: Text(
                  //               "HOME",
                  //               style: TextStyle(
                  //                 fontSize: 20.0,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ),
                  //           Center(
                  //             child: Text(
                  //               "REMEDIES",
                  //               style: TextStyle(
                  //                 fontSize: 20.0,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ),
                  //         ]),
                  //   ),
                  // ),
                  Expanded(
                    //JOIN COMMUNITY
                    child: ReusableCard(
                      height: 150.0,
                      colour: colour,
                      onPress: () {
                        Navigator.pushNamed(context, community.id);
                      },
                      cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Icon(
                                Icons.group,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                            Center(
                              child: Text(
                                "COMMUNITY",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    //APPOINTMENT
                    child: ReusableCard(
                      height: 150.0,
                      colour: colour,
                      onPress: () {
                        Navigator.pushNamed(context, Appointment.id);
                      },
                      cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Icon(
                                Icons.assignment,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                            Center(
                              child: Text(
                                "BOOK",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                "APPOINTMENT",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Expanded(
                    //ABOUT US
                    child: ReusableCard(
                      height: 150.0,
                      colour: colour,
                      onPress: () {
                        Navigator.pushNamed(context, AboutUs.id);
                      },
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Icon(
                              Icons.description,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                          Center(
                            child: Text(
                              "ABOUT US",
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
