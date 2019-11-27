import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin extends StatefulWidget {
  String adminToBeSearched;

  Admin(
    String adminToBeSearched,
  ) {
    this.adminToBeSearched = adminToBeSearched;
  }

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  List admins = [];

  String newadmin;

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(
            "admins",
          )
          .snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return SizedBox();
        }
        admins.clear();
        for (DocumentSnapshot doc in snap.data.documents) {
          admins.add(
            doc.data['username'],
          );
        }

        return Row(
          children: <Widget>[
            admins.contains(widget.adminToBeSearched)
                ? IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                          child: AlertDialog(
                            content: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Add admin by username",
                                        style: TextStyle(
                                          color: Colors.cyan,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextField(
                                    onChanged: (String x) {
                                      this.newadmin = x;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "Add Admin",
                                  style: TextStyle(
                                    color: Colors.pink,
                                  ),
                                ),
                                onPressed: () {
                                  newadmin.isNotEmpty
                                      ? Firestore.instance
                                          .collection('admins')
                                          .add(
                                          {
                                            'username': newadmin,
                                          },
                                        )
                                      : null;
                                  newadmin.isNotEmpty
                                      ? Navigator.pop(context)
                                      : null;
                                },
                              )
                            ],
                          ),
                          context: context);
                    },
                  )
                : SizedBox(),
            admins.contains(widget.adminToBeSearched)
                ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Firestore.instance
                          .collection('msgDetails')
                          .getDocuments()
                          .then(
                        (snapshot) {
                          for (DocumentSnapshot ds in snapshot.documents) {
                            ds.reference.delete();
                          }
                        },
                      );
                    },
                  )
                : SizedBox(),
          ],
        );
      },
    );
  }
}
