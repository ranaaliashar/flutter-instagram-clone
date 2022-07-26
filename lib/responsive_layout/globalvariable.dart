// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instgram_flutter/Screens/add_post.dart';
import 'package:instgram_flutter/Screens/feed_scree.dart';
import 'package:instgram_flutter/Screens/profile_screen.dart';
import 'package:instgram_flutter/Screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> HomeScreenItems = [
 const FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Center(child: Text('favrouites')),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];
