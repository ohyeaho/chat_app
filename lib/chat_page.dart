import 'package:chat_app/home.dart';
import 'package:chat_app/post_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage(this.user);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat'),
        actions: [
          Column(
            children: [
              Container(
                height: 38,
                child: IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return Home();
                      }),
                    );
                  },
                  icon: Icon(Icons.logout),
                ),
              ),
              Container(
                child: Text(
                  'ログアウト',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Text(
          'ログイン情報:${user.email}',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return PostPage(user);
            }),
          );
        },
      ),
    );
  }
}
