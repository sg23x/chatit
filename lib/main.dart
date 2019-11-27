import 'package:chat/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message.dart';
import 'admin.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chatit",
      theme: ThemeData(
        hintColor: Colors.white,
      ),
      home: LoginPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  String name;
  String username;

  ChatPage(
    String name,
    String username,
  ) {
    this.name = name;
    this.username = username;
  }

  _ChatPageState createState() => _ChatPageState(
        name,
        username,
      );
}

List<Message> messages = [];

class _ChatPageState extends State<ChatPage> {
  @override
  _ChatPageState(
    String name,
    String username,
  ) {
    this.name = name;
    this.username = username;
  }
  String s, name, username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        actions: <Widget>[
          Admin(
            username,
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.power_settings_new,
          ),
          onPressed: () {
            showDialog(
              context: context,
              child: AlertDialog(
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.cyan,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Yeah",
                      style: TextStyle(
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ],
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "You sure you wanna log out?",
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        backgroundColor: Colors.white12,
        elevation: 50,
        centerTitle: true,
        title: Text(
          "CHATIT",
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 8.0,
            left: 0.0,
            right: 0.0,
            bottom: MediaQuery.of(context).size.height * 0.09 + 3.0,
            child: StreamBuilder(
              stream: Firestore.instance.collection('msgDetails').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        children: <Widget>[
                          CircularProgressIndicator(),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ],
                  );
                }
                messages.clear();
                for (DocumentSnapshot doc in snapshot.data.documents) {
                  messages.insert(
                    messages.length,
                    Message(
                      doc.data,
                    ),
                  );
                }
                messages.sort(
                  (
                    a,
                    b,
                  ) =>
                      a.time.compareTo(
                    b.time,
                  ),
                );

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, i) {
                    return ChatBox(
                      messages[i].messageContent,
                      messages[i].sender,
                      i != 0 ? messages[i - 1].sender : null,
                      i != messages.length - 1 ? messages[i + 1].sender : null,
                      username,
                      name,
                      messages[i].name,
                      i,
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: BottomBar(
              username,
              name,
            ),
          ),
        ],
      ),
    );
  }
}
