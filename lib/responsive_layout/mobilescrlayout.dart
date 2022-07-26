import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instgram_flutter/Utils/colors.dart';
import 'package:instgram_flutter/responsive_layout/globalvariable.dart';
// import 'package:instgram_flutter/models/usermodel.dart' as model;
// import 'package:instgram_flutter/providers/user_provider.dart';
// import 'package:provider/provider.dart';

class MobileScr extends StatefulWidget {
  const MobileScr({Key? key}) : super(key: key);

  @override
  State<MobileScr> createState() => _MobileScrState();
}

class _MobileScrState extends State<MobileScr> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTaped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;
    // ignore: prefer_const_constructors
    return Scaffold(
        // ignore: prefer_const_constructors
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            // ignore: prefer_const_constructors
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: _page == 1 ? primaryColor : secondaryColor),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add,
                  color: _page == 2 ? primaryColor : secondaryColor),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: _page == 3
                  ? Icon(Icons.favorite,
                      color: _page == 3 ? primaryColor : secondaryColor)
                  : Icon(Icons.favorite_border_outlined),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _page == 4 ? primaryColor : secondaryColor),
              label: '',
              backgroundColor: primaryColor,
            ),
          ],
          onTap: navigationTaped,
        ),
        body: PageView(
          children: HomeScreenItems,
          onPageChanged: onPageChanged,
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
        ));
  }
}



//////////////////////////////////////////////////////////
// older way to get data from the database now using provider to get it easily and short way
// String  username= '';

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUsername();
//   }

//   void getUsername()async{
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance
//     .collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
//     .get();

//     // print(snapshot.data());
//     setState(() {
//       username =(snapshot.data() as Map<String, dynamic>)['username'];
//     });
//   }
