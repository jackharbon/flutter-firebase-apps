import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:message_app/services/database.dart';

class Post {
  String avatar;
  String author;
  String body;
  String uid;
  String createdAt;
  Set userLiked = {};
  Set userDontLiked = {};
  late DatabaseReference _id;

  Post(
    this.avatar,
    this.author,
    this.body,
    this.uid,
    this.createdAt,
  );

  void likePost(User user) {
    if (userLiked.contains(user.uid)) {
      userLiked.remove(user.uid);
    } else {
      userLiked.add(user.uid);
      if (userDontLiked.contains(user.uid)) userDontLiked.remove(user.uid);
    }
    print('====> post | likePost userLiked: ${userLiked.toString()}');
    print('====> post | likePost userDontLiked: ${userDontLiked.toString()}');
    update();
  }

  void likeNotPost(User user) {
    if (userDontLiked.contains(user.uid)) {
      userDontLiked.remove(user.uid);
    } else {
      userDontLiked.add(user.uid);
      if (userLiked.contains(user.uid)) userLiked.remove(user.uid);
    }
    print('====> post | likeNotPost userLiked: ${userLiked.toString()}');
    print(
        '====> post | likeNotPost userDontLiked: ${userDontLiked.toString()}');
    update();
  }

  void update() {
    updatePost(this, _id);
  }

  void edit(body, id) {
    print('====> post | edit: $body');
    updatePost(this, _id);
  }

  void remove() {
    removePost(this, _id);
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
        'createdAt': createdAt,
        'userLiked': userLiked.toList(),
      };
    } else if (userDontLiked.toList().isNotEmpty) {
      return {
        'avatar': avatar,
        'author': author,
        'body': body,
        'uid': uid,
        'createdAt': createdAt,
        'userDontLiked': userDontLiked.toList(),
      };
    } else {
      return {
        'avatar': avatar,
        'author': author,
        'body': body,
        'uid': uid,
        'createdAt': createdAt,
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
    'createdAt': '',
    'userLiked': [],
    'userDontLiked': [],
  };

  record.forEach((key, value) => attributes[key] = value);

  Post post = Post(
    attributes['avatar'],
    attributes['author'],
    attributes['body'],
    attributes['uid'],
    attributes['createdAt'],
  );
  if (attributes['userLiked'].isNotEmpty) {
    post.userLiked = Set.from(attributes['userLiked']);
  }
  if (attributes['userDontLiked'].isNotEmpty) {
    post.userDontLiked = Set.from(attributes['userDontLiked']);
  }
  print('====> post | post: $post');
  return post;
}
