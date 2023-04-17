import 'package:flutter/material.dart';
import 'package:message_app/models/post.dart';
import 'package:message_app/services/database.dart';
import 'package:message_app/common/text_input.dart';
import 'package:message_app/models/post_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  final User user;

  const MyHomePage(this.user);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  void newPost(String text) {
    var post = Post(text, widget.user.displayName!);
    post.setId(savePost(post));
    setState(() {
      posts.add(post);
    });
    print(
        '====> home_page | post: ${post.body} ${post.author} ${post.userLiked}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: PostList(posts, widget.user)),
          TextInputWidget(newPost),
        ],
      ),
    );
  }
}
