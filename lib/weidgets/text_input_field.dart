import 'package:flutter/material.dart';

class MyTextInputField extends StatefulWidget {
 final String hintText;
 final TextInputType textInputType;
 final TextEditingController textEditingController;
 final bool isPassed;
  const MyTextInputField({ Key? key, 
  required this.textEditingController,
  required this.hintText,
  this.isPassed=false,
  required this.textInputType,
  }) : super(key: key);

  @override
  State<MyTextInputField> createState() => _MyTextInputFieldState();
}

class _MyTextInputFieldState extends State<MyTextInputField> {
  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide()
    );
    return TextFormField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        border: inputBorder,
        hintText:widget.hintText,
        filled: true,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        contentPadding: const EdgeInsets.all(08)        
        ),
        keyboardType: widget.textInputType,
        obscureText: widget.isPassed,
    );
  }
}