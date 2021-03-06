import 'package:chat_app/home.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/post_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  var user;

  ChatPage(this.user);

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final User user = userState.user;

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
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'ログイン情報:${user.email}',
              ),
            ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .orderBy('date')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DocumentSnapshot> documents = snapshot.data.docs;
                return ListView(
                  children: documents.map((document) {
                    return Card(
                      child: ListTile(
                        title: Text(document['text']),
                        subtitle: Text(document['email']),
                        trailing: document['email'] == user.email
                            ? IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('posts')
                                      .doc(document.id)
                                      .delete();
                                },
                                icon: Icon(Icons.delete),
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                );
              }
              return Center(
                child: Text('読込中...'),
              );
            },
          ))
        ],
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
