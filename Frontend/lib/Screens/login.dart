import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homeScreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class login extends StatefulWidget {
  static String id = "login";
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _auth = FirebaseAuth.instance;
  String email;
  String pass;
  bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("REMICURE")),
        backgroundColor: Colors.black54,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
            child: Container(
              height: 800,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:AssetImage("images/app11.jpg"),
                    fit: BoxFit.cover
                ),
              ),
              child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),

                  Row(
                    children:[
                      Hero(
                        tag: 'logo',
                        child: Icon(
                        Icons.add,
                        color: Colors.red[900],
                        size: 150,

                    ),
                      ),
                      Container(
                        height:80,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Be",
                              style: TextStyle(fontSize: 40.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // SizedBox(width: 20,),
                            Container(
                              width: 190,
                              child: RotateAnimatedTextKit(
                                text: ["CAREFUL", "SAFE", "AWARE"],
                                textStyle: TextStyle(fontSize: 35.0, fontFamily: "Horizon", color: Colors.white, fontWeight: FontWeight.bold,),
                                textAlign: TextAlign.start,
                                // isRepeatingAnimation: true,
                                repeatForever: true,

                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.grey.withAlpha(140),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListBody(
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5,),
                            TextField(
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.email,
                                    color:Colors.white
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.6),

                                  focusColor: Colors.lightBlue[100],
                                  labelText: 'Enter your Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color:Colors.white,
                              ),
                            ),
                            SizedBox(height: 5,),
                            TextField(

                              onChanged: (value) {
                                pass = value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.account_circle_rounded,
                                      color:Colors.white
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.6),

                                  focusColor: Colors.lightBlue[100],
                                  labelText: 'Enter your Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            FlatButton(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  showSpinner=true;
                                });
                                try {
                                  final user = await _auth.signInWithEmailAndPassword(
                                      email: email, password: pass);
                                  // displayName=email;
                                  if (user != null) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('LOGIN SUCCESSFUL!!'),
                                          content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(
                                                    'PROCEED',
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
                                                'PROCEED',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                             onPressed:(){
                                                Navigator.pushNamed(context, HomeScreen.id);
                                                setState(() {
                                                  showSpinner=true;
                                                });
                                             }
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          // backgroundColor: Colors.grey.withAlpha(200),
                                          title: Text('LOGIN UNSUCCESSFUL!!'),
                                          content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(
                                                    'ENTER CORRECT USERNAME OR PASSWORD',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          actions: <Widget>[
                                            RaisedButton(
                                              child: Text('BACK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              color: Colors.blueAccent.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
