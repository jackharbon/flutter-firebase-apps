import 'package:flutter/material.dart';
import 'package:message_app/models/post.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostList extends StatefulWidget {
  final List<Post> listItems;
  final User user;

  PostList(this.listItems, this.user);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callback) {
    setState(() {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.listItems.length,
        itemBuilder: (context, index) {
          var post = widget.listItems[index];
          return Card(
              child: Row(children: <Widget>[
            Expanded(
                child: ListTile(
              title: Text(post.body),
              subtitle: Text(post.author),
            )),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      post.userLiked.length.toString(),
                      style: const TextStyle(fontSize: 20),
                    )),
                IconButton(
                  onPressed: () => like(() => post.likePost(widget.user)),
                  splashColor: Colors.orange[200],
                  color: post.userLiked.contains(widget.user.uid)
                      ? Colors.orange
                      : Colors.grey,
                  icon: const Icon(Icons.thumb_up),
                ),
              ],
            )
          ]));
        });
  }
}
