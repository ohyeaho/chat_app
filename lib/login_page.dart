import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String loginUserEmail = '';
  String loginUserPassword = '';
  String infoText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'メールアドレス',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onChanged: (String value) {
                  setState(() {
                    loginUserEmail = value;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'パスワード',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    loginUserPassword = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result =
                        await auth.signInWithEmailAndPassword(
                      email: loginUserEmail,
                      password: loginUserPassword,
                    );

                    final User user = result.user;
                    setState(() {
                      infoText = 'ログインOK:${user.email}';
                      Navigator.pushReplacementNamed(context, "/chat_page");
                    });
                  } catch (e) {
                    setState(() {
                      infoText = 'ログインNG:${e.toString()}';
                    });
                  }

                  // FirebaseAuth.instance
                  //     .authStateChanges()
                  //     .listen((User user) {
                  //   if (user != null) {
                  //     Navigator.pushReplacementNamed(context, "/home");
                  //   }
                  // });
                },
                child: Text('ログイン'),
              ),
              SizedBox(
                height: 15,
              ),
              Text(infoText)
            ],
          ),
        ),
      ),
    );
  }
}
