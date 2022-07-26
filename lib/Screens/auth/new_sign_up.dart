// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:instgram_flutter/Screens/auth/new_resources/new_auth_methods.dart';
// import 'package:instgram_flutter/Screens/sign_up.dart';
// import 'package:instgram_flutter/Utils/colors.dart';
// import 'package:instgram_flutter/weidgets/text_input_field.dart';

// class NewSignUP extends StatefulWidget {
//   const NewSignUP({ Key? key }) : super(key: key);

//   @override
//   _NewSignUpState createState() => _NewSignUpState();
// }

// class _NewSignUpState extends State<NewSignUP> {
//   final TextEditingController _emailController = TextEditingController();
//     final TextEditingController _passwordController = TextEditingController();
//      final TextEditingController _usernameController = TextEditingController();
//       final TextEditingController _bioController = TextEditingController();

//        @override
//     void dispose(){
//       super.dispose();
//       _emailController.dispose();
//       _passwordController.dispose();
//       _usernameController.dispose();
//       _bioController.dispose();
//     }
//   @override
//   Widget build(BuildContext context) {    
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 32),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Flexible(child: Container(),
//               flex: 2,),
//               SvgPicture.asset('assets/logo.svg',
//               color: primaryColor,
//               height: 64,
//               ),
//               const SizedBox(height: 60,),
//               // circular image
//               // const SizedBox(
//               //       height: 20,
//               //     ),
//                   Stack(
//                     children: [
//                       const CircleAvatar(
//                         radius: 64,
//                         backgroundImage: NetworkImage(
//                             'https://media-exp1.licdn.com/dms/image/C5603AQHfK439rtFJ8g/profile-displayphoto-shrink_200_200/0/1639764134038?e=1648080000&v=beta&t=pJl_he58dHcp0IRahgs4qXm9-uNxQMvDV0OitSo44Kw'),
//                       ),
//                       Positioned(
//                         bottom: -10,
//                         left: 80,
//                         child: IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.add_a_photo)),
//                       )
//                     ],
//                   ),
//               // username field
//                const  SizedBox(height: 24,),
//               MyTextInputField(
//                 textEditingController: _usernameController, 
//                 hintText: 'Enter username', 
//                 textInputType: TextInputType.text
                 
//                  ),
//               // email field
//               const  SizedBox(height: 24,),
//               MyTextInputField(
//                 textEditingController: _emailController, 
//                 hintText: 'Enter your e-mail', 
//                 textInputType: TextInputType.text
                 
//                  ),
//                  // password field
//                  const  SizedBox(height: 24,),
//                  MyTextInputField(
//                 textEditingController: _passwordController, 
//                 hintText: 'Enter your password', 
//                 textInputType: TextInputType.text,
//                 isPassed: true,
//                  ),
//                // bio field
//                const  SizedBox(height: 24,),
//               MyTextInputField(
//                 textEditingController: _bioController, 
//                 hintText: 'Enter your bio', 
//                 textInputType: TextInputType.text
                 
//                  ),
//                  // button to register
//                 const  SizedBox(height: 24,),
//                 InkWell(
//                   onTap: () async{
//                     String res = await NewAuthMethods().signUpMethod(
//                       email: _emailController.text, 
//                       password: _passwordController.text, 
//                       username: _usernameController.text, 
//                       bio: _bioController.text
//                       );
//                       print('email:' + _emailController.text);
//                        print('password' + _passwordController.text);
//                         print('bio:' + _bioController.text);
//                          print('username:' + _usernameController.text);
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     // ignore: prefer_const_constructors
//                     decoration: ShapeDecoration(
//                       shape:const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                       ),
//                       color: blueColor,
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       width: double.infinity,
//                       child: const Text("Login"),
//                   ),
//                 ),
//                 Flexible(child: Container(),
//               flex: 2,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 // ignore: prefer_const_literals_to_create_immutables
//                 children: [
//                  const  Text('Do you have an account?'),
                 
//                   GestureDetector(
//                     onTap: (() {
//                       Navigator.of(context).push(MaterialPageRoute(builder: (contxt)=>SignUp()));
//                     }),
//                     child: Container(
//                       child: const Text('SignUp',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
                  
//                       ),),
//                     ),
//                   )
//                 ],
//               )
//             ]),
//         ),
//       ),
//     );
//   }
// }