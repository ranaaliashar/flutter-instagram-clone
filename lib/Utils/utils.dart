import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

imagePicker(ImageSource source) async{
final ImagePicker _imagePicker = ImagePicker();

XFile? _file = await _imagePicker.pickImage(source: source);
if(_file != null){
  return await _file.readAsBytes();
}
print('mun changa nae tasveer ksi hor di la ly');
}

showsnackBar(String content, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content))
  );
}
