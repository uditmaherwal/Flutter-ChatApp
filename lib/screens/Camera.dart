import 'package:flutter/material.dart';
import 'dart:async';
import 'Home.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _image;
  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text(
                    'No image yet selected'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  )
                : Container(
                    height: 600.0,
                    width: 600.0,
                    margin: EdgeInsets.all(10.0),
                    child: Image.file(
                      _image,
                    ),
                  ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    gradient: LinearGradient(colors: [
                      Colors.grey,
                      Colors.blueGrey,
                    ]),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      getImage(true);
                    },
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    gradient: LinearGradient(colors: [
                      Colors.grey,
                      Colors.blueGrey,
                    ]),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.photo_library),
                    onPressed: () {
                      getImage(false);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
