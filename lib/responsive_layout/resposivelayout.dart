import 'package:flutter/material.dart';
import 'package:instgram_flutter/providers/user_provider.dart';
import 'package:instgram_flutter/responsive_layout/globalvariable.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final webScrLayout;
  final mobileScrLayout;
  const ResponsiveLayout({ Key? key, required this.mobileScrLayout, required this.webScrLayout }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }
  addData()async{
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context, constrints){
        if(constrints.maxWidth > webScreenSize){
          return widget.webScrLayout;
        }
        return widget.mobileScrLayout;
      }
    );
  }
}