// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgram_flutter/Utils/colors.dart';
import 'package:instgram_flutter/Utils/utils.dart';
import 'package:instgram_flutter/models/usermodel.dart';
import 'package:instgram_flutter/providers/user_provider.dart';
import 'package:instgram_flutter/resources/firestoremethods/firestoremethods.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  // function to select iamge
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create a post'),
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Take photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await imagePicker(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await imagePicker(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  // Uint8List file = await imagePicker(ImageSource.gallery);
                  // setState(() {
                  //   _file = file;
                  // });
                },
              ),
            ],
          );
        });
  }

  // function to add post image
  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadImage(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );

      if (res == "success") {
        setState(() {
      _isLoading = false;
    });
        showsnackBar('Successfully posted!', context);
        clearImage();
      } else {
        setState(() {
      _isLoading = false;
    });
        showsnackBar(res, context);
      }
    } catch (e) {
      showsnackBar(e.toString(), context);
    }
  }

  void clearImage(){
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
                onPressed: () => _selectImage(context),
                icon: Icon(
                  Icons.upload,
                  size: 50,
                  color: Colors.red,
                )),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                  onPressed: clearImage,
                  icon: const Icon(Icons.arrow_back_ios_sharp)),
              title: const Text('Post to'),
              // ignore: prefer_const_literals_to_create_immutables
              actions: [
                TextButton(
                    onPressed: () => postImage(
                          user.uid,
                          user.username,
                          user.photoUrl,
                        ),
                    child: const Text(
                      'Post',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ))
              ],
            ),
            body: Column(
              children: [
                _isLoading? LinearProgressIndicator():
                Padding(padding: EdgeInsets.all(0)),
                Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.photoUrl,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      // ignore: prefer_const_constructors
                      child: TextField(
                        // ignore: prefer_const_constructors
                        controller: _descriptionController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintMaxLines: 8,
                            hintText: 'Write a Caption...'),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(image: MemoryImage(_file!)),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ),
          );
  }
}
