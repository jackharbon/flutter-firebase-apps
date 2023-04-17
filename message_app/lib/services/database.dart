import 'package:firebase_database/firebase_database.dart';
import 'package:message_app/models/post.dart';

final databaseReference = FirebaseDatabase.instance.ref();

DatabaseReference savePost(Post post) {
  var id = databaseReference.child('posts/').push();
  print('====> database | databaseReference: ${databaseReference.toString()}');
  id
      .set(post.toJson())
      .then((_) => print('====> database | $id written to database'))
      .catchError((error) => print('====> database | error: $error'));
  print('====> database | post: ${post.body} ${post.author} ${post.userLiked}');
  return id;
}
