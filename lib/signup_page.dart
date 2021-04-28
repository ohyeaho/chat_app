import 'package:chat_app/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String email = '';
  String password = '';
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
                    email = value;
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
                    password = value;
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
                    final result = await auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return ChatPage(result.user);
                      }),
                    );
                  } catch (e) {
                    setState(() {
                      infoText = '登録に失敗しました:${e.toString()}';
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
