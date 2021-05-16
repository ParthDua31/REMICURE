import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remedico/Components/reusableCard.dart';
import 'package:remedico/constants.dart';
import 'package:http/http.dart' as http;
import 'homeScreen.dart';
import 'dart:convert';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
Future<Album> _futureAlbum;
// http.Response response;
String fTitle;
List<DropdownMenuItem> dI = [];
List<String> diseaseListI = [];

List<DropdownMenuItem> dE = [];
List<String> diseaseListE = [];

class Album {
  final String title;
  final String body;
  final String category;
  final String usermail;
  Album({this.title, this.body, this.category, this.usermail});

  Map toJson() => {
        'title': title,
        'body': body,
        'category': category,
        'usermail': usermail,
      };
}

class community extends StatefulWidget {
  static String id = "Community";
  @override
  _communityState createState() => _communityState();
}

class _communityState extends State<community> {
  int c_value = 1;
  int d_value = 0;
  String titleText;
  String desc;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    dI.clear();
    dE.clear();
    diseaseListE.clear();
    diseaseListI.clear();
    getInternalData();
    getExternalData();
  }

  void getInternalData() async {
    http.Response response = await http
        .get('https://remedy-api.herokuapp.com/disease-list/internal');
    if (response.statusCode == 200) {
      var title = jsonDecode(response.body);
      for (int i = 0; i < title.length; i++) {
        titleText = jsonDecode(response.body)[i]['title'];
        diseaseListI.add(titleText);
        dI.add(DropdownMenuItem(
          child: Text(
            "$titleText",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          value: i,
        ));
      }
    } else {
      print(response.statusCode);
    }
  }

  void getExternalData() async {
    http.Response response = await http
        .get('https://remedy-api.herokuapp.com/disease-list/external');
    if (response.statusCode == 200) {
      var title = jsonDecode(response.body);
      for (int i = 0; i < title.length; i++) {
        titleText = jsonDecode(response.body)[i]['title'];
        diseaseListE.add(titleText);
        dE.add(DropdownMenuItem(
          child: Text(
            "$titleText",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          value: i,
        ));
      }
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text('REMICURE'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(

                decoration: BoxDecoration(
                    color: Colors.black54,
                ),
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
                  onTap: (){
                    Navigator.pushNamed(context, 'setting');
                  }
              ),
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
        body: SafeArea(
            child: Container(
              height: 800,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:AssetImage("images/app2.jpg"),
                    fit: BoxFit.cover
                ),
              ),

              child: SingleChildScrollView(
          child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.grey.withAlpha(180),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListBody(
                        children: [
                          Text(
                            "Select Category",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                              // fontWeight: FontWeight,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButton(
                            dropdownColor: Colors.white.withOpacity(0.8),
                            iconEnabledColor: Colors.black,
                            value: c_value,
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                  "Internal",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  "External",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                value: 2,
                              )
                            ],
                            onChanged: (value) {
                              setState(() {
                                c_value = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Select Disease",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButton(
                              iconEnabledColor: Colors.black,
                              dropdownColor: Colors.white.withOpacity(0.8),
                              value: d_value,
                              items: c_value == 1 ? dI : dE,
                              onChanged: (value) {
                                setState(() {
                                  d_value = value;
                                  fTitle = c_value == 1
                                      ? diseaseListI[d_value]
                                      : diseaseListE[d_value];
                                });
                              }),
                          SizedBox(height: 50),
                          Text(
                            "Enter the Description",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            onChanged: (value) {
                              desc = value;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                focusColor: Colors.lightBlue[100],
                                labelText: 'Description',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
                          ),
                          SizedBox(height: 50),
                          Container(
                              child: FlatButton(
                            child: Text(
                              'SUBMIT',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            color: Colors.blueAccent.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white)
                            ),
                            onPressed: () async {
                              Album makepost = Album(
                                  title: c_value==1 ? diseaseListI[d_value] : diseaseListE[d_value],
                                  body: desc,
                                  category:
                                      c_value == 1 ? 'Internal' : 'External',
                                  usermail: '${_auth.currentUser.email}');
                              var apiResult = await http.post(
                                  "https://remedy-api.herokuapp.com/makepost",
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(makepost));

                              if (apiResult.statusCode == 200) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('POST SUBMITTED'),
                                      content: SingleChildScrollView(
                                          child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Your post is submitted for verification.',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )),
                                      actions: <Widget>[
                                        RaisedButton(
                                          color: Colors.lightBlue,
                                          child: Text(
                                            'BACK',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.popUntil(context, ModalRoute.withName('HomeScreen'));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                print(apiResult.statusCode);
                              }
                            },
                          ))
                        ],
                      ),
                    )),
              ),
          ),
        ),
            )));
  }
}
