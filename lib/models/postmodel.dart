import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Post{
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImages;
  final likes;

  Post({required this.description,
  required this.uid,
  required this.username,
  required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImages,
  required this.likes
  });

  Map<String , dynamic> toJson()=>{
    "description":description,
    "uid": uid,
    "username": username,
    "postId": postId,
    "datePublished": datePublished,
    "postUrl": postUrl,
    "profImages": profImages,
    "likes": likes,
  };

  static Post fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      description: snapshot['description'],
       uid: snapshot['uid'],
       username: snapshot['username'],
       datePublished: snapshot['datePublished'],
       postId: snapshot['postId'],
        postUrl: snapshot['postUrl'],
         profImages: snapshot['profImages'],
         likes: snapshot['likes'],

         );
  }
}