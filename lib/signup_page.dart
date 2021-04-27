import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String newUserEmail = '';
  String newUserPassword = '';
  String infoText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー登録'),
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
                    newUserEmail = value;
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
                    newUserPassword = value;
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
                        await auth.createUserWithEmailAndPassword(
                      email: newUserEmail,
                      password: newUserPassword,
                    );

                    final User user = result.user;
                    setState(() {
                      infoText = '登録OK:${user.email}';
                    });
                  } catch (e) {
                    setState(() {
                      infoText = '登録NG:${e.toString()}';
                    });
                  }
                },
                child: Text('登録'),
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
