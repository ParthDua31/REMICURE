import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:remedico/Components/appointmentCard.dart';
import 'package:remedico/constants.dart';

class Appointment extends StatefulWidget {
  static String id = "Appointment";
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("BOOK AN APPOINTMENT"),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image:AssetImage("images/app2.jpg"),
                fit: BoxFit.cover
            ),
          ),
          child:BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: SingleChildScrollView(
              child: Column(
              children: <Widget>[
                AppointmentCard(
                  name: "Dr. Shashank Agrawal",
                  desc1: 'Bachelor of Ayurvedic Medicines and Surgery',
                  desc2: 'Ayurvedic Doctor',
                  desc3: 'Pranacharya Arogyam Delhi',
                  desc4: 'Gujranwala Town, Delhi',
                ),
                AppointmentCard(
                  name: "Dr.G S Lavekar",
                  desc1: 'Ph.D - Ayurveda, MD - Ayurveda',
                  desc2: 'Ayurvedic Doctor',
                  desc3: 'Lavekar Clinic',
                  desc4: 'Dwarka, Delhi',
                ),
                AppointmentCard(
                  name: "Dr.Jyoti Monga",
                  desc1: 'Bachelor of Ayurveda, Medicine and Surgery (BAMS)',
                  desc2: 'Ayurvedic Doctor',
                  desc3: 'Dr Monga Medi Clinic - Lajpat Nagar',
                  desc4: 'Lajpat Nagar, Delhi',
                ),
                AppointmentCard(
                  name: "Dr.Ashish Sharma",
                  desc1:
                      'M.Sc - Psychology, PGDEMS, Bachelor of Ayurveda, Medicine and Surgery (BAMS)',
                  desc2: 'Ayurvedic Doctor',
                  desc3: 'Arogyam Ayurveda',
                  desc4: 'Paschim Vihar, Delh',
                ),
                AppointmentCard(
                  name: "Dr.Rakesh Gupta",
                  desc1:
                      'N.D.D.Y, Bachelor of Ayurveda Medicine & Surgery (BAMS), Specialist In Ayurvedic Ksharsutra Therapy',
                  desc2: 'Ayurvedic Doctor',
                  desc3: 'Center For Piles & Fistula',
                  desc4: 'Delhi',
                ),
                AppointmentCard(
                  name: "Dr.Sandeep Madaan",
                  desc1: 'MD - Ayurveda',
                  desc2: 'Ayurvedic Doctor',
                  desc3: 'Aastha Ayurveda Clinic',
                  desc4: 'Rohini, Delhi',
                ),
                AppointmentCard(
                  name: "Dr.Malik Ayurvedacharya",
                  desc1: 'Bachelor of Ayurveda, Medicine and Surgery (BAMS)',
                  desc2: 'Ayurvedic Doctor',
                  desc3: 'Ayurveda Sanjeevani',
                  desc4: 'Akota, Delhi',
                ),
              ],
            ),
        ),
          ),
      ),
    );
  }
}
