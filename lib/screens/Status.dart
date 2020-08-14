import 'package:flutter/material.dart';
import 'package:mywhatsapp/reusable/wcards.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Wcards('My Status', 'Tap to add status',
            "https://images.pexels.com/photos/1149022/pexels-photo-1149022.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
        Divider(),
        Heading('Recent Updates'),
        Wcards(
          'Udit Maherwal',
          'messageData[1].time',
          "messageData[https://images.pexels.com/photos/1427288/pexels-photo-1427288.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500].imageUrl",
        ),
        Wcards(
          'Udit Maherwal',
          'messageData[1].time',
          "messageData[1].imageUrl",
        ),
        Heading('Today'),
        Wcards(
          'Udit Maherwal',
          'messageData[1].time',
          "messageData[1].imageUrl",
        ),
      ],
    );
  }
}

class Heading extends StatelessWidget {
  final String heading;
  Heading(this.heading);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 5.0, top: 5.0),
        child: Text(
          this.heading,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
