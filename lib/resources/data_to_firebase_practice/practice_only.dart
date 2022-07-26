import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PracticeOnly extends StatefulWidget {
  const PracticeOnly({ Key? key }) : super(key: key);

  @override
  _PracticeOnlyState createState() => _PracticeOnlyState();
}

class _PracticeOnlyState extends State<PracticeOnly> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  addFun() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection('Pakistan').add({
      "email": emailC.text, 
      "password" : passwordC.text
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/bg.jpg',),
            fit: BoxFit.cover)
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            height: double.infinity,
          width: double.infinity,
          color: Colors.red.withOpacity(0.5),
            child: Column(
              children: [
              Text('Add Data'),
              SizedBox(height: 50,),
              TextField(
                controller: emailC,
              ),
              TextField(
                controller: passwordC,
              ),
              SizedBox(height: 50,),
              ElevatedButton(onPressed: (){
                addFun();
              }, child: 
              Text('Add Data'),)
            ]),
          ),
        ),
      ),
    );
  }
}