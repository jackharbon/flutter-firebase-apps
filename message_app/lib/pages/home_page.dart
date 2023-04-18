import 'package:flutter/material.dart';
import 'package:message_app/models/post.dart';
import 'package:message_app/services/database.dart';
import 'package:message_app/common/text_input.dart';
import 'package:message_app/models/post_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  final User user;

  const MyHomePage(
    this.user,
  );
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];
  String postedDateString = DateTime.now().toLocal().toString();

  void newPost(String text) {
    var post = Post(
      widget.user.photoURL!,
      widget.user.displayName!,
      text,
      widget.user.uid,
      postedDateString,
    );
    post.setId(savePost(post));
    setState(() {
      posts.add(post);
    });
    print(
        '====> home_page | newPost author: ${post.author} body: ${post.body} posted: ${post.posted} uid: ${post.uid} liked: {post.userLiked}');
  }

  void updateMessages() async {
    await getAllPosts().then((posts) => {
          setState(() => {
                this.posts = posts,
              })
        });
    print('====> home_page | updateMessages: $posts}');
  }

  @override
  void initState() {
    super.initState();
    updateMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Posts'),
            CircleAvatar(
              backgroundImage: NetworkImage(
                widget.user.photoURL!,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: PostList(
            posts,
            widget.user,
          )),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text('You are logged in as: ${widget.user.displayName}'),
          ),
          TextInputWidget(newPost),
        ],
      ),
    );
  }
}
