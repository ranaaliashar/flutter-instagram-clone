import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User{
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  User({required this.email,
  required this.bio,
  required this.uid,
  required this.username,
  required this.photoUrl,
  required this.followers,
  required this.following
  });

  Map<String , dynamic> toJson()=>{
    "email":email,
    "uid": uid,
    "username": username,
    "bio": bio,
    "photoUrl": photoUrl,
    "followers": followers,
    "following": following
  };

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
       bio: snapshot['bio'],
       uid: snapshot['uid'],
       username: snapshot['username'],
       photoUrl: snapshot['photoUrl'],
        followers: snapshot['followers'],
         following: snapshot['following']
         );
  }
}