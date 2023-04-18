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
          final DateTime postedTime = DateTime.parse(post.posted).toLocal();
          final DateTime currentTime = DateTime.now();
          final difference = currentTime.difference(postedTime);
          return Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 8, 0),
            child: Column(
              children: [
                Text('$difference'),
                Card(
                    child: Row(children: <Widget>[
                  Expanded(
                      child: ListTile(
                    title: Text(
                      '${post.author} | ${post.posted}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    subtitle: Text(
                      post.body,
                      style: const TextStyle(fontSize: 18),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        post.avatar,
                      ),
                    ),
                  )),
                ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          iconSize: 18.0,
                          onPressed: () => like(() => {
                                post.likePost(widget.user),
                                print(
                                    '====> post_list | widget.user: ${widget.user}'),
                              }),
                          splashColor: Colors.orange[200],
                          color: post.userLiked.contains(widget.user.uid)
                              ? Colors.orange
                              : Colors.black87,
                          icon: const Icon(Icons.thumb_up_alt_outlined),
                        ),
                        Text(
                          post.userLiked.length.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          iconSize: 18.0,
                          onPressed: () => {},
                          splashColor: Colors.orange[200],
                          color: post.userLiked.contains(widget.user.uid)
                              ? Colors.black
                              : Colors.grey,
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          iconSize: 18.0,
                          onPressed: () => {},
                          splashColor: Colors.red[200],
                          color: post.userLiked.contains(widget.user.uid)
                              ? Colors.red
                              : Colors.grey,
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
