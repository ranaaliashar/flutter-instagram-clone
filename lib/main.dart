import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instgram_flutter/Screens/auth/new_sign_up.dart';
import 'package:instgram_flutter/Screens/login_scr.dart';
import 'package:instgram_flutter/Screens/sign_up.dart';
import 'package:instgram_flutter/Utils/colors.dart';
import 'package:instgram_flutter/providers/user_provider.dart';
import 'package:instgram_flutter/responsive_layout/mobilescrlayout.dart';
import 'package:instgram_flutter/responsive_layout/resposivelayout.dart';
import 'package:instgram_flutter/responsive_layout/webscrlayout.dart';
import 'package:provider/provider.dart';

void  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor
        ),
          
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                return const ResponsiveLayout(
          mobileScrLayout: MobileScr(), 
          webScrLayout: WebScr());
              }
              
            }else if(snapshot.hasError){
              Center(child: Text('${snapshot.error}'));
            }
            if(snapshot.connectionState== ConnectionState.waiting){
              Center(child: CircularProgressIndicator(color: primaryColor,));
            }
            return SignUp();
          })
        
         
        
      ),
    );
  }
}

