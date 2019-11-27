import 'package:chat/createuser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  String username;
  List users = [];
  List pass = [];
  List names = [];
  int ind;
  String _pass;
  String password;
  bool newuser = false;
  bool wrongpass = false;
  bool obscure = true;
  String name;

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        }
        users.clear();
        pass.clear();
        names.clear();
        for (DocumentSnapshot doc in snapshot.data.documents) {
          users.add(
            doc.data['username'],
          );
          pass.add(
            doc.data['password'],
          );
          names.add(
            doc.data['name'],
          );
        }

        return Scaffold(
          backgroundColor: Colors.white10,
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      maxLength: 15,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: "Enter Username",
                        errorText: newuser ? "username not recognized" : null,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                          borderSide: new BorderSide(
                            color: Colors.white,
                            width: 0.0,
                          ),
                        ),
                      ),
                      onChanged: (String x) {
                        this.username = x.toLowerCase().trim();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: obscure,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: "Enter Password",
                        errorText: wrongpass ? "Wrong password" : null,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                          borderSide: new BorderSide(
                            color: Colors.white,
                            width: 0.0,
                          ),
                        ),
                      ),
                      maxLength: 20,
                      onChanged: (String x) {
                        this.password = x;
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            obscure = !obscure;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  setState(
                    () {
                      users.contains(username)
                          ? newuser = false
                          : newuser = true;
                      !newuser ? ind = users.indexOf(username) : ind = null;
                      ind != null ? _pass = pass[ind] : null;
                      _pass != password ? wrongpass = true : wrongpass = false;
                      ind != null ? name = names[ind] : null;
                    },
                  );
                  _pass == password
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ChatPage(
                              name,
                              username,
                            ),
                          ),
                        )
                      : null;
                },
                child: Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.cyan,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "New here?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      "Sign up here",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => CreateUser(),
                        ),
                      );
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ],
          ),
        );
      },
    );
  }
}
