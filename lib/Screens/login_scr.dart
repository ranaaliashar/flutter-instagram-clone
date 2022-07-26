import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instgram_flutter/Screens/sign_up.dart';
import 'package:instgram_flutter/Utils/colors.dart';
import 'package:instgram_flutter/Utils/utils.dart';
import 'package:instgram_flutter/resources/auth_methods.dart';
import 'package:instgram_flutter/responsive_layout/mobilescrlayout.dart';
import 'package:instgram_flutter/responsive_layout/resposivelayout.dart';
import 'package:instgram_flutter/responsive_layout/webscrlayout.dart';
import 'package:instgram_flutter/weidgets/text_input_field.dart';

class LoginScr extends StatefulWidget {
  const LoginScr({Key? key}) : super(key: key);

  @override
  _LoginScrState createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailcontroller = TextEditingController();
    final TextEditingController _passwordcontroller = TextEditingController();
    bool _isloading = false;

    @override
    void dispose() {
      super.dispose();
      _emailcontroller.dispose();
      _passwordcontroller.dispose();
    }

    void loginUser() async {
      setState(() {
        _isloading = true;
      });
      String res = await AuthMethods().signInUser(
          email: _emailcontroller.text, password: _passwordcontroller.text);
      if (res == 'successfully logedIn') {
        Navigator.of(context)
          .push(MaterialPageRoute(builder: (contxt) =>
      const ResponsiveLayout(
        mobileScrLayout: MobileScr(), 
        webScrLayout: WebScr())
        )
        );
      } else {
        // setState(() {
        //   _isloading = false;
        // });
        showsnackBar(res, context);
      }
      setState(() {
        _isloading = false;
      });
    }

    void navigateToSignUp() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (contxt) => const SignUp()));
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                SvgPicture.asset(
                  'assets/logo.svg',
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(
                  height: 60,
                ),
                // email field
                MyTextInputField(
                    textEditingController: _emailcontroller,
                    hintText: 'Enter your e-mail',
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 24,
                ),
                MyTextInputField(
                  textEditingController: _passwordcontroller,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.visiblePassword,
                  isPassed: true,
                ),

                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: loginUser,
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
                    child: _isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : const Text("Login"),
                  ),
                ),
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('Do you have an account?'),
                    GestureDetector(
                      onTap: navigateToSignUp,
                      child: Container(
                        child: const Text(
                          'SignUp',
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
      ),
    );
  }
}
