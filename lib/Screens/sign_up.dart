// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgram_flutter/Screens/login_scr.dart';
import 'package:instgram_flutter/Utils/colors.dart';
import 'package:instgram_flutter/Utils/utils.dart';
import 'package:instgram_flutter/resources/auth_methods.dart';
import 'package:instgram_flutter/weidgets/text_input_field.dart';

import '../responsive_layout/mobilescrlayout.dart';
import '../responsive_layout/resposivelayout.dart';
import '../responsive_layout/webscrlayout.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController usernameC = TextEditingController();
  final TextEditingController bioC = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passwordC.dispose();
    usernameC.dispose();
    bioC.dispose();
  }

  // call pick image method inside select image

  selectImage() async {
    Uint8List im = await imagePicker(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpuser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: emailC.text,
      password: passwordC.text,
      username: usernameC.text,
      bio: bioC.text,
      file: _image!,
    );
    //  print(_image);
    //  print('password' + passwordC.text);
    //   print('bio:' + bioC.text);
    //    print('username:' + usernameC.text);
             print(res);
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showsnackBar(res, context);
    }else{
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (contxt) =>
      const ResponsiveLayout(
        mobileScrLayout: MobileScr(), 
        webScrLayout: WebScr())
        )
        );
    }
  }
  void navigateToLogin() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (contxt) => const LoginScr()));
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flexible(child: Container(),
                  // flex: 2,),
                  SvgPicture.asset(
                    'assets/logo.svg',
                    color: primaryColor,
                    height: 64,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      // ignore: prefer_const_constructors
                      _image != null
                          ? CircleAvatar(
                              radius: 64, backgroundImage: MemoryImage(_image!))
                          : CircleAvatar(
                              radius: 68,
                              backgroundColor: Colors.blueGrey.shade100,
                              child: CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                              ),
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: const Icon(Icons.add_a_photo)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // username field
                  MyTextInputField(
                      textEditingController: usernameC,
                      hintText: 'Enter your username',
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 24,
                  ),
                  MyTextInputField(
                    textEditingController: emailC,
                    hintText: 'Enter your e-mail',
                    textInputType: TextInputType.text,
                    // isPassed: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MyTextInputField(
                    textEditingController: passwordC,
                    hintText: 'Enter your password',
                    textInputType: TextInputType.text,
                    isPassed: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MyTextInputField(
                      textEditingController: bioC,
                      hintText: 'Enter Bio',
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 24,
                  ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     String res = await AuthMethods.signUpUser(
                  //       email: emailC.text,
                  //       username: usernameC.text,
                  //       password: passwordC.text,
                  //       bio: bioC.text,
                  //     );
                  //     print(res);
                  //   },
                  //   child: const Text("SignUp"),
                  // ),

                  InkWell(
                    onTap: signUpuser,
                    child: Container(
                      alignment: Alignment.center,
                      // ignore: prefer_const_constructors
                      decoration: ShapeDecoration(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        color: blueColor,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      width: double.infinity,
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text("SignUp"),
                    ),
                  ),
                  //   Flexible(child: Container(),
                  // flex: 2,),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text('Alread have an account?'),
                      GestureDetector(
                        onTap: navigateToLogin,
                        child: Container(
                          child: const Text(
                            ' Login?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
