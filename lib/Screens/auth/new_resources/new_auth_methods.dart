// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class NewAuthMethods {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   String res = 'Bhai hal ho ja';

//   //signUp user
//   Future<String> signUpMethod({
//     required String email,
//     required String password,
//     required String username,
//     required String bio,
//     //  required Uint8List file,
//   }) async {
    
//     try {
//       if (email.isNotEmpty ||
//           password.isNotEmpty ||
//           username.isNotEmpty ||
//           bio.isNotEmpty) {
//         // register a user
//         UserCredential cred = await _auth.createUserWithEmailAndPassword(
//             email: email, password: password);
//         print(cred.user!.uid);
//         // add user to firebase
//          _firestore.collection('user').doc(cred.user!.uid).set({
//            "username": username,
//            "uid": cred.user!.uid,
//            "email": email,
//            "bio": bio,
//            "followers": [],
//            "following":[],
//          });
//         //
//         // await _firestore.collection('user').add({
//         //   "username": username,
//         //   "uid": cred.user!.uid,
//         //   "email": email,
//         //   "bio": bio,
//         //   "followers": [],
//         //   "following": [],
//         // });
//         res = "success";
//       }
//     } catch (err) {
//       err.toString();
//     }
//     return res;
//   }
// }
