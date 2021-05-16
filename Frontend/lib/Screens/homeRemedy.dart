import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remedico/Components/reusableCard.dart';
import 'package:remedico/constants.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'commonScreen.dart';
import 'package:remedico/Screens/setting.dart';
import 'login.dart';
List<ReusableCard> cardsI = [];
List<String> diseaseListI =[];

List<ReusableCard> cardsE = [];
List<String> diseaseListE =[];

class HomeRemedy extends StatefulWidget {
  static String id = "HomeRemedy";

  @override
  _HomeRemedyState createState() => _HomeRemedyState();
}

class _HomeRemedyState extends State<HomeRemedy> {
  final List<Tab> myTabs = [
    Tab(icon: Icon(Icons.local_hospital), text: 'Internal'),
    Tab(
      icon: Icon(Icons.medical_services),
      text: 'External',
    ),
  ];
  @override
  void initState() {
    super.initState();
    cardsI.clear();
    cardsE.clear();
    diseaseListI.clear();
    diseaseListE.clear();
    getInternalData();
    getExternalData();
    // showCards();
  }

  void getInternalData() async{
    http.Response response= await http.get('https://remedy-api.herokuapp.com/disease-list/internal');
    if(response.statusCode==200){
          setState(() {
            showSpinner=false;
          });
        var title=jsonDecode(response.body);
        // title.map((element){
        for(int i=0;i<title.length;i++){
          titleText = jsonDecode(response.body)[i]['title'];
          diseaseListI.add(titleText);
          setState(() {
            cardsI.add(ReusableCard(
              onPress:() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Common(titleText: '${diseaseListI[i]}')));
              },
              colour: Colors.grey.withAlpha(200),
              cardChild: ListTile(
                title: Text(
                  "$titleText",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            ));
          });

        }
    }
    else{
      print(response.statusCode);
    }
  }


  void getExternalData() async{
    http.Response response= await http.get('https://remedy-api.herokuapp.com/disease-list/external');
    if(response.statusCode==200){
      setState(() {
        showSpinner=false;
      });
      var title=jsonDecode(response.body);
      for(int i=0;i<title.length;i++){
        titleText = jsonDecode(response.body)[i]['title'];
        diseaseListE.add(titleText);
        setState(() {
          cardsE.add(ReusableCard(
            onPress:() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Common(titleText: '${diseaseListE[i]}'),));
            },
            colour: Colors.grey.withAlpha(200),
            cardChild: ListTile(
              title: Text(
                "$titleText",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          ));
        });

      }
    }
    else{
      print(response.statusCode);
    }
  }
  @override
  String titleText;
  String description;
  bool showSpinner=true;
  final _auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: myTabs,
          ),
          title: Center(child: Text("HOME REMEDIES")),
          backgroundColor: Colors.black54,
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
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: TabBarView(
            children: [
              Scaffold(
                // body:  ListView(
                //   shrinkWrap: true,
                //   children: cards,
                // )
                body:Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:AssetImage("images/app2.jpg"),
                        fit: BoxFit.cover
                    ),
                  ),

                  // child: BackdropFilter(
                    // filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: cardsI.length,
                      itemBuilder: (context,i){
                        if(cardsI[i] != null){
                          return (
                              cardsI[i]
                          );
                        }
                      },
                    ),
                  // ),
                ),
              ),
              Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:AssetImage("images/app2.jpg"),
                        fit: BoxFit.cover
                    ),
                  ),
                  child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: cardsE.length,
                      itemBuilder: (context,i){
                        if(cardsE[i] != null){
                          return (
                              cardsE[i]
                          );
                        }
                      },
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

