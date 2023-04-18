import 'package:firebase_database/firebase_database.dart';
import 'package:message_app/models/post.dart';

final databaseReference = FirebaseDatabase.instance.ref();

DatabaseReference savePost(Post post) {
  var id = databaseReference.child('posts/').push();
  id
      .set(post.toJson())
      .then((_) => print(
          '====> database | savePost set ${post.toJson()} written to database'))
      .catchError((error) => print('====> database | error: $error'));
  print(
      '====> database | savePost author: ${post.author} body: ${post.body} posted: ${post.posted} liked: ${post.userLiked} uid: ${post.uid}');
  return id;
}

void updatePost(Post post, DatabaseReference id) {
  id.update(post.toJson());
}

Future<List<Post>> getAllPosts() async {
  DataSnapshot dataSnapshot =
      (await databaseReference.child('posts/').once()).snapshot;
  print('====> database | dataSnapshot.value: ${dataSnapshot.value}');

  List<Post> posts = [];
  if (dataSnapshot.value != null) {
    (dataSnapshot.value as Map<Object?, Object?>).forEach((key, value) {
      print('====> database | getAllPosts value: $value}');
      Post post = createPost(value);
      print('====> database | getAllPosts post: $post}');
      post.setId(databaseReference.child('posts/$key'));
      posts.add(post);
    });
  }

  print('====> database | getAllPosts posts: $posts}');
  return posts;
}
