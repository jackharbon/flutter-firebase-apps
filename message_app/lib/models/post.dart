import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Post {
  String body;
  String author;
  Set userLiked = {};
  DatabaseReference? _id;

  Post(this.body, this.author);

  void likePost(User user) {
    if (userLiked.contains(user.uid)) {
      userLiked.remove(user.uid);
    } else {
      userLiked.add(user.uid);
    }
  }

  void setId(DatabaseReference id) {
    _id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'body': body,
      // 'id': _id,
      'userLiked': userLiked.toList()
    };
  }
}
