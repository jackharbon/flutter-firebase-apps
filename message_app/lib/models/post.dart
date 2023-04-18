import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:message_app/services/database.dart';

class Post {
  String avatar;
  String author;
  String body;
  String uid;
  String posted;
  Set userLiked = {};
  late DatabaseReference _id;

  Post(
    this.avatar,
    this.author,
    this.body,
    this.uid,
    this.posted,
  );

  void likePost(User user) {
    if (userLiked.contains(user.uid)) {
      userLiked.remove(user.uid);
    } else {
      userLiked.add(user.uid);
    }
    update();
  }

  void update() {
    updatePost(this, _id);
  }

  void setId(DatabaseReference id) {
    _id = id;
  }

  Map<String, dynamic> toJson() {
    if (userLiked.toList().isNotEmpty) {
      return {
        'avatar': avatar,
        'author': author,
        'body': body,
        'uid': uid,
        'posted': posted,
        'userLiked': userLiked.toList(),
      };
    } else {
      return {
        'avatar': avatar,
        'author': author,
        'body': body,
        'uid': uid,
        'posted': posted,
      };
    }
  }
}

Post createPost(record) {
  Map<String, dynamic> attributes = {
    'avatar': '',
    'author': '',
    'body': '',
    'uid': '',
    'posted': '',
    'userLiked': [],
  };

  record.forEach((key, value) => attributes[key] = value);

  Post post = Post(
    attributes['avatar'],
    attributes['author'],
    attributes['body'],
    attributes['uid'],
    attributes['posted'],
  );
  if (attributes['userLiked'].isNotEmpty) {
    post.userLiked = Set.from(attributes['userLiked']);
  }
  print('====> post | post: post');
  return post;
}
