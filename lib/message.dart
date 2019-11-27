import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String messageContent;
  int time;
  String sender;
  String name;

  Message(Map<String, dynamic> data) {
    this.messageContent = data["message"];
    this.time = data["timestamp"];
    this.sender = data["username"];
    this.name = data["name"];
  }
}

class ChatBox extends StatelessWidget {
  @override
  String senderusername;
  String myname;
  int n;
  String msg;
  String prevsenderusername;
  String nextsenderusername;
  String myusername;
  String sendername;
  ChatBox(
    String msg,
    String senderusername,
    String prevsenderusername,
    String nextsenderusername,
    String myusername,
    String myname,
    String sendername,
    int n,
  ) {
    this.msg = msg;
    this.senderusername = senderusername;
    this.n = n;
    this.myname = myname;
    this.prevsenderusername = prevsenderusername;
    this.nextsenderusername = nextsenderusername;
    this.myusername = myusername;
    this.sendername = sendername;
  }
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: senderusername != myusername
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.015,
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: senderusername != prevsenderusername && n != 0
                  ? MediaQuery.of(context).size.height * 0.015
                  : MediaQuery.of(context).size.height * 0.005,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: myusername != senderusername &&
                          nextsenderusername != senderusername
                      ? Radius.circular(15)
                      : myusername == senderusername
                          ? Radius.circular(
                              0,
                            )
                          : Radius.circular(0),
                  topRight: prevsenderusername != senderusername
                      ? Radius.circular(
                          15,
                        )
                      : Radius.circular(
                          0,
                        ),
                  topLeft: prevsenderusername != senderusername
                      ? Radius.circular(
                          15,
                        )
                      : Radius.circular(
                          0,
                        ),
                  bottomLeft: myusername == senderusername &&
                          nextsenderusername != senderusername
                      ? Radius.circular(
                          15,
                        )
                      : Radius.circular(
                          0,
                        ),
                ),
                color: senderusername != myusername ? Colors.pink : Colors.cyan,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.0,
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    n != 0 &&
                            senderusername != myusername &&
                            prevsenderusername != senderusername
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.019,
                                right:
                                    MediaQuery.of(context).size.width * 0.019,
                                top: MediaQuery.of(context).size.height *
                                    0.0055),
                            child: Text(
                              sendername,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.045,
                              ),
                            ),
                          )
                        : n == 0
                            ? senderusername != myusername
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.019,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.019,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.0055),
                                    child: Text(
                                      sendername,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.045,
                                      ),
                                    ),
                                  )
                                : SizedBox()
                            : SizedBox(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.019,
                        right: MediaQuery.of(context).size.width * 0.019,
                        bottom: MediaQuery.of(context).size.height * 0.008,
                        top: senderusername == myusername
                            ? MediaQuery.of(context).size.height * 0.005
                            : 0.0,
                      ),
                      child: Text(
                        msg,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.015,
        ),
      ],
    );
  }
}

class BottomBar extends StatefulWidget {
  @override
  String senderusername;
  String sendername;
  BottomBar(String senderusername, String sendername) {
    this.senderusername = senderusername;
    this.sendername = sendername;
  }
  _BottomBarState createState() => _BottomBarState(senderusername, sendername);
}

class _BottomBarState extends State<BottomBar> {
  @override
  String myusername;
  String myname;
  _BottomBarState(String senderusername, String sendername) {
    this.myusername = senderusername;
    this.myname = sendername;
  }
  String s;
  TextEditingController _cont = new TextEditingController();

  void createMessage(String msg, String myusername, String myname) async {
    msg != null
        ? await Firestore.instance.collection("msgDetails").add(
            {
              'timestamp': Timestamp.now().seconds,
              'name': myname,
              'message': msg,
              'username': myusername,
            },
          )
        : null;
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      height: MediaQuery.of(context).size.height * 0.09,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.06,
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Write a message...",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: new BorderSide(
                    color: Colors.white,
                    width: 0.0,
                  ),
                ),
              ),
              textInputAction: TextInputAction.go,
              onSubmitted: (String s) {
                s != ""
                    ? createMessage(
                        s.trim(),
                        myusername,
                        myname,
                      )
                    : null;
                setState(
                  () {
                    s = "";
                  },
                );

                _cont.clear();
              },
              onChanged: (String s) {
                setState(
                  () {
                    this.s = s;
                  },
                );
              },
              controller: _cont,
            ),
          ),
          StreamBuilder(
            stream: Firestore.instance.collection('msgDetails').snapshots(),
            builder: (context, snapshot) {
              return FloatingActionButton(
                onPressed: () {
                  s != ""
                      ? createMessage(
                          s.trim(),
                          myusername,
                          myname,
                        )
                      : null;
                  setState(
                    () {
                      s = "";
                    },
                  );

                  _cont.clear();
                },
                backgroundColor: Colors.pink,
                child: Icon(Icons.chevron_right,
                    size: MediaQuery.of(context).size.width * 0.1,
                    color: Colors.black),
              );
            },
          ),
        ],
      ),
    );
  }
}
