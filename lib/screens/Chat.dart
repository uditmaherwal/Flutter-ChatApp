import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mywhatsapp/helper/constants.dart';
import 'package:mywhatsapp/helper/helperfunctions.dart';
import 'package:mywhatsapp/screens/ConversationScreen.dart';
import 'package:mywhatsapp/services/database.dart';
import 'package:strings/strings.dart';
import 'SearchScreen.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  DatabaseMethods databaseMethods = DatabaseMethods();

  Stream chatRooms;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatTile(
                    snapshot.data.documents[index].data["chatroomId"]
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    snapshot.data.documents[index].data["chatroomId"],
                  );
                },
              )
            : Container();
      },
    );
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNamePreferenceKey();
    databaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRooms = value;
      });
    });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ));
        },
        child: Icon(
          Icons.message,
          size: 28.0,
        ),
        elevation: 8.0,
        splashColor: Colors.blueGrey[500],
      ),
      body: chatRoomList(),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ConversationScreen(chatRoomId);
            },
          ));
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Row(
            children: [
              Divider(
                height: 5.0,
              ),
              CircleAvatar(
                maxRadius: 25.0,
                backgroundColor: Colors.blueGrey[200],
                child: Text(
                  '${userName.substring(0, 1).toUpperCase()}',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(
                width: 22.0,
              ),
              Text(
                capitalize(userName),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  color: Colors.blueGrey[800],
                ),
              ),
              Spacer(),
            ],
          ),
        ));
  }
}
