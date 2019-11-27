import 'package:chat/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  @override
  String name = "", username = "", password = "", repassword = "";
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;
  bool _validate4 = false;
  bool obscure1 = true;
  bool obscure2 = true;
  bool _usernametaken = false;

  List usernames = [];

  void createUserAccount(
    String username,
    String name,
    String password,
  ) async {
    username != null &&
            name != null &&
            password.length > 5 &&
            password == repassword &&
            !usernames.contains(username)
        ? await Firestore.instance.collection("users").add(
            {
              'username': username,
              'name': name,
              'password': password,
            },
          )
        : null;
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("users").snapshots(),
      builder: (context, snap) {
        usernames.clear();

        if (!snap.hasData) {
          return SizedBox();
        }
        for (DocumentSnapshot doc in snap.data.documents) {
          usernames.add(
            doc.data['username'],
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
                        labelText: "Select Username",
                        errorText: _validate3
                            ? "Can't be empty"
                            : _usernametaken ? "username already taken" : null,
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
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      maxLength: 25,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: "Display Name",
                        errorText: _validate4 ? "Can't be empty" : null,
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
                        this.name = x.trim();
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
                      obscureText: obscure1,
                      decoration: InputDecoration(
                        counterText: "",
                        labelText: "Enter Password",
                        errorText: _validate1
                            ? "Password should be at least 6 digits"
                            : null,
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
                            obscure1 = !obscure1;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      obscureText: obscure2,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: "Re Enter Password",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        errorText: _validate2 ? "Password don't match" : null,
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
                        this.repassword = x;
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
                            obscure2 = !obscure2;
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
                  createUserAccount(
                    username,
                    name,
                    password,
                  );

                  username != null &&
                          name != null &&
                          password.length > 5 &&
                          password == repassword &&
                          !usernames.contains(username)
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

                  setState(
                    () {
                      password.length > 5
                          ? _validate1 = false
                          : _validate1 = true;
                      password == repassword
                          ? _validate2 = false
                          : _validate2 = true;
                      username.isEmpty ? _validate3 = true : _validate3 = false;
                      name.isEmpty ? _validate4 = true : _validate4 = false;
                      usernames.contains(username)
                          ? _usernametaken = true
                          : _usernametaken = false;
                    },
                  );
                },
                child: Text(
                  "Sign Up",
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
                    "Already Signed up?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      "Log in here",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage(),
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
