// import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homeScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class sign_up extends StatefulWidget {
  static String id = "signup";
  @override
  _sign_upState createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  @override
  final _auth = FirebaseAuth.instance;
  String email;
  String pass1;
  String pass2;
  bool showSpinner=false;
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SafeArea(
                child:Container(
                  height:900,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:AssetImage("images/app11.jpg"),
                        fit: BoxFit.cover
                    ),
                  ),
                  child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                        Row(children: [
                          Hero(
                            tag:'logo',

                            child: Icon(
                            Icons.add,
                            color: Colors.red[900],
                            size: 90,

                        ),
                          ),
                          TypewriterAnimatedTextKit(text:["REMICURE"], textStyle:TextStyle(
                            fontSize: 50.0,
                            fontFamily: "Agne",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                            speed: Duration(milliseconds: 100),
                          ), ],),

                            SizedBox(
                              height:20,
                            ),

                          Container(
                            height:80,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Be",
                                  style: TextStyle(fontSize: 32.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // SizedBox(width: 20,),
                                Container(
                                  width: 150,
                                  child: RotateAnimatedTextKit(
                                      text: ["CAREFUL", "SAFE", "AWARE"],
                                      textStyle: TextStyle(fontSize: 28.0, fontFamily: "Horizon", color: Colors.white, fontWeight: FontWeight.bold,),
                                      textAlign: TextAlign.start,
                                    // isRepeatingAnimation: true,
                                    repeatForever: true,

                                  ),
                                ),
                              ],
                            ),
                          ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                color: Colors.grey.withAlpha(80),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListBody(
                                    children: [
                                      Text('Email',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextField(
                                        onChanged: (value){
                                          email=value;
                                        },
                                        decoration: InputDecoration(

                                            icon: Icon(Icons.email,color: Colors.white,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white.withOpacity(0.6),
                                            focusColor: Colors.white,
                                            labelText: 'Enter your Email',
                                            border: OutlineInputBorder(
                                              borderRadius:BorderRadius.all(Radius.circular(10)),
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Password',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextField(
                                        onChanged: (value){
                                          pass1=value;
                                        },
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.account_circle_rounded,color: Colors.white
                                            ),
                                            filled: true,
                                            fillColor: Colors.white.withOpacity(0.6),
                                            focusColor: Colors.lightBlue[100],
                                            labelText: 'Enter your Password',
                                            border: OutlineInputBorder(
                                              borderRadius:BorderRadius.all(Radius.circular(10)),
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Confirm Password',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextField(
                                        onChanged: (value){
                                          pass2=value;
                                        },
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.account_circle_rounded,color: Colors.white
                                            ),
                                            filled: true,
                                            fillColor: Colors.white.withOpacity(0.6),
                                            focusColor: Colors.lightBlue[100],
                                            labelText: 'Enter your Password',
                                            border: OutlineInputBorder(
                                              borderRadius:BorderRadius.all(Radius.circular(10)),
                                            )
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      FlatButton(

                                        child: Text('Sign-Up',style: TextStyle(
                                          color: Colors.white,
                                        ),),
                                        onPressed: () async {
                                          setState(() {
                                            showSpinner=true;
                                          });
                                          try{
                                            if(pass1==pass2){
                                              final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: pass1);
                                              // displayName=email;
                                              if (newUser != null) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text('SIGN-UP SUCCESSFUL!!'),
                                                      content: SingleChildScrollView(
                                                          child: ListBody(
                                                            children: <Widget>[
                                                              Text('PROCEED TO APP ',
                                                                style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.bold,
                                                                ),),
                                                            ],
                                                          )
                                                      ),
                                                      actions: <Widget>[
                                                        RaisedButton(
                                                          color: Colors.lightBlue,
                                                          child: Text(
                                                            'PROCEED', style: TextStyle(
                                                            color: Colors.white,
                                                          ),),
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,  HomeScreen.id);
                                                            setState(() {
                                                              showSpinner=false;
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            }
                                            else{
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text('UNSUCCESSFUL!!'),
                                                    content:SingleChildScrollView(
                                                        child:ListBody(
                                                          children: <Widget>[
                                                            Text('PLEASE ENTER SAME PASSWORD IN BOTH THE FIELDS',style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                            ),),
                                                          ],

                                                        )
                                                    ),
                                                    actions: <Widget>[
                                                      RaisedButton(
                                                        color:Colors.lightBlue,
                                                        child: Text('BACK',style: TextStyle(
                                                          color: Colors.white,
                                                        ),),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                          showSpinner=false;
                                                        },
                                                      ),
                                                    ],

                                                  );
                                                },
                                              );
                                            }
                                          }
                                          catch(e){
                                            print(e);
                                          }
                                        },
                                        color: Colors.blueAccent.withOpacity(0.8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.white)
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(child: Text('Have an Existing Account ?',style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),)),
                                      SizedBox(
                                        width: 50,
                                        child: FlatButton(
                                          child: Text('Login',style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                          onPressed:(){
                                            Navigator.pushNamed(context, 'login');
                                          },
                                          color: Colors.blueAccent.withOpacity(0.8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                              side: BorderSide(color: Colors.white)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                )

            ),
          ),
        )
    );
  }
}
