import 'dart:convert';
import 'dart:ui';
import 'package:remedico/Screens/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:remedico/constants.dart';

List<Card> cardsI = [];
List<dynamic> upvoted_by = [];
List<dynamic> downvoted_by = [];

class Common extends StatefulWidget {
  static String id = "Common";
  String titleText;
  Common({this.titleText});
  @override
  _CommonState createState() => _CommonState(titleText);
}

class _CommonState extends State<Common> {
  String titleText;
  _CommonState(this.titleText);

  final List<Tab> myTabs = [
    Tab(icon: Icon(Icons.local_hospital), text: 'Description'),
    Tab(
      icon: Icon(Icons.medical_services),
      text: 'Posts',
    ),
  ];

  String description;
  @override
  void initState() {
    super.initState();
    cardsI.clear();
    getDescription();
    getPostData();
  }

  final _auth = FirebaseAuth.instance;
  String postData;
  String bodyText;
  int tVotes;
  int upVotes;
  bool verify;
  String id;
  int downVotes;
  String mail;
  bool showSpinner = true;
  int x = 0;
  void getPostData() async {
    http.Response response = await http.get('https://remedy-api.herokuapp.com/post/${titleText}');
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      var title = jsonDecode(response.body);
      for (int i = 0; i < title.length; i++) {
        bodyText = jsonDecode(response.body)[i]['body'];
        upVotes = jsonDecode(response.body)[i]['upvote'];
        downVotes=jsonDecode(response.body)[i]['downvote'];
        tVotes = jsonDecode(response.body)[i]['totalvotes'];
        verify = jsonDecode(response.body)[i]['verified'];
        id = jsonDecode(response.body)[i]['_id'];
        mail = jsonDecode(response.body)[i]['usermail'];
        upvoted_by = jsonDecode(response.body)[i]['upvotedBy'];
        downvoted_by = jsonDecode(response.body)[i]['downvotedBy'];
        if (upvoted_by.contains(_auth.currentUser.email)) {
          setState(() {
            x = 1;
          });
        } else if (downvoted_by.contains(_auth.currentUser.email)) {
          setState(() {
            x = 2;
          });
        } else {
          setState(() {
            x = 0;
          });
        }

        setState(() {
          cardsI.add(Card(
            color: Colors.white.withOpacity(0.7),
            elevation: 10.0,
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListBody(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 350,),
                          verify == true
                              ? Icon(
                            Icons.verified,
                            color: Colors.green,
                          )
                              : Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '$mail',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        bodyText,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 70,
                          ),
                          GestureDetector(
                            onTap: () async {
                              http.Response response = await http.get(
                                  'https://remedy-api.herokuapp.com/post/upvote/$id?user=${_auth.currentUser.email}');
                              // tVotes[i]++;
                              cardsI.clear();
                              getPostData();
                              setState(() {
                                x = 1;
                              });
                            },
                            child: Icon(
                              Icons.thumb_up,
                              color: x == 1 ? Colors.blueAccent : Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Text('$upVotes'),
                          SizedBox(
                            width: 100,
                          ),
                          GestureDetector(
                              onTap: () async {
                                http.Response response = await http.get(
                                    'https://remedy-api.herokuapp.com/post/downvote/$id?user=${_auth.currentUser.email}');
                                cardsI.clear();
                                getPostData();
                                setState(() {
                                  x = 2;
                                });
                              },
                              child: Icon(
                                Icons.thumb_down,
                                color:
                                    x == 2 ? Colors.blueAccent : Colors.black,
                              )),
                          SizedBox(width: 20,),
                          Text('$downVotes'),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 290,
                          ),
                          Text('Rating: ${upVotes}/${tVotes}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
      }
    } else {
      print(response.statusCode);
    }
  }

  void getDescription() async {
    http.Response response2 = await http.get('https://remedy-api.herokuapp.com/singleDisease/$titleText');
    if (response2.statusCode == 200) {
      setState(() {
        showSpinner = false;
        description = jsonDecode(response2.body)[0]['description'];
      });
    } else {
      print(response2.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: Background,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text('$titleText'),
          bottom: TabBar(
            tabs: myTabs,
          ),
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
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: TabBarView(children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:AssetImage("images/app2.jpg"),
                    fit: BoxFit.cover
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(

                      child: Image(
                        image: AssetImage('images/$titleText.jpg'),
                        fit: BoxFit.cover,
                      ),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                      elevation: 10,
                      margin: EdgeInsets.all(10),
                    ),
                    Card(
                      color: Colors.white.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "$description",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 10,
                      margin: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
            ),
            Container(

              decoration: BoxDecoration(
                image: DecorationImage(
                    image:AssetImage("images/app2.jpg"),
                    fit: BoxFit.cover
                ),
              ),
              child: ListView.builder(
                // shrinkWrap: true,
                itemCount: cardsI.length,
                itemBuilder: (context, i) {
                  if (cardsI[i] != null) {
                    return (cardsI[i]);
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
