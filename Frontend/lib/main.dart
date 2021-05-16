import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:remedico/Screens/AboutUs.dart';
import 'package:remedico/Screens/Appointment.dart';
import 'package:remedico/Screens/community.dart';
import 'Screens/commonScreen.dart';
import 'Screens/homeRemedy.dart';
import 'Screens/homeScreen.dart';
import 'Screens/login.dart';
import 'Screens/setting.dart';
import 'Screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Remedico());
}

class Remedico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      initialRoute: sign_up.id,
      routes: {
        login.id: (context) => login(),
        sign_up.id: (context) => sign_up(),
        HomeScreen.id: (context) => HomeScreen(),
        HomeRemedy.id: (context) => HomeRemedy(),
        Common.id: (context) => Common(),
        Appointment.id: (context) => Appointment(),
        AboutUs.id: (context) => AboutUs(),
        community.id: (context) => community(),
        setting.id: (context) => setting(),
      },
    );
  }
}
