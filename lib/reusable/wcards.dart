import 'package:flutter/material.dart';

class Wcards extends StatelessWidget {
  final String name, imageurl, time;

  Wcards(this.name, this.time, this.imageurl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        maxRadius: 25.0,
        foregroundColor: Colors.deepPurple[200],
        backgroundImage: NetworkImage(imageurl),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(time),
    );
  }
}
