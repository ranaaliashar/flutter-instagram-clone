import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instgram_flutter/models/usermodel.dart' as model;
import 'package:instgram_flutter/resources/storage_methods.dart';
// import 'package:flutter/material.dart';

// final FirebaseAuth auth = FirebaseAuth.instance;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

class AuthMethods {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<model.User> getUserDetails()async{
    User currentUser= _auth.currentUser!;
    DocumentSnapshot snap = await firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }
// SignUp method
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (
        email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty
          // ||    file != null
          ) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // saving image
        String photoUrl = await storageMethods()
            .uploadImagetoStorage('profilePics', file, false);
        // print(photoUrl);

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
          email: email,
        );
        await firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        // other method to sign up
        // await firestore.collection('user').add({
        //    'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'follwers': [],
        //   'following': [],
        //   'photoUrl' : photoUrl
        // });
        // await _firestore
        //     .collection("users")
        //     .doc(cred.user!.uid)
        //     .set(_user.toJson());

        return res = 'success';
      }
    }
    // on FirebaseAuthException catch(err){
    //   if(err== 'invalid-email'){
    //     res = 'Enter some valid e-mail';
    //   }
    //    else if(err.code == 'weak-password'){
    //       res = 'password atleast of 6 also add special symbol to make it strong';
    //     }
    // }

    catch (err) {
      res = err.toString();
    }
    return res;
  }

  // loging in with email and password

  Future<String> signInUser(
      {required String email, required String password}) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'successfully logedIn';
      } else {
        res = 'Please Enter all fields above';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  Future<void>signOut()async{
    await _auth.signOut();
  }
}
