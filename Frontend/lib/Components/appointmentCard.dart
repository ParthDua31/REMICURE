import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  AppointmentCard(
      {@required this.name,
      @required this.desc1,
      @required this.desc2,
      @required this.desc3,
      @required this.desc4});

  final String name;
  final String desc1;
  final String desc2;
  final String desc3;
  final String desc4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        // color: Colors.grey.withAlpha(200),
        color: Colors.grey.withOpacity(0.8),
        elevation: 15.0,
        child: ListBody(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 14.0),
              child: Text(
                desc1,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 14.0),
              child: Text(
                desc2,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 14.0),
              child: Text(
                desc3,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 14.0),
              child: Text(
                desc4,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                  width: 50,
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: ElevatedButton(
                  child: Text(
                    'Book Appointment',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('CONFIRMATION MESSAGE!!'),
                          content: SingleChildScrollView(
                              child: ListBody(
                            children: <Widget>[
                              Text(
                                'Your Appointment with $name is confirmed.',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text(
                                'BACK',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
