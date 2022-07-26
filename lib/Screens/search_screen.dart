import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instgram_flutter/Screens/profile_screen.dart';
import 'package:instgram_flutter/Utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowusers = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'search for user',
            ),
            onFieldSubmitted: (String _) {
              // print(searchController.text);
              setState(() {
                isShowusers = true;
              });
            },
          ),
        ),
        body: isShowusers
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where(
                      'username',
                      isGreaterThanOrEqualTo: searchController.text,
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }

                  return ListView.builder(
                      itemCount: (snapshot.data as dynamic).docs.length,
                      itemBuilder: ((context, index) {
                        // ignore: prefer_const_constructors
                        return ListTile(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                uid: (snapshot.data as dynamic).docs[index]
                                    ['uid'],
                              ),
                            ),
                          ),
                          // ignore: prefer_const_constructors
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                (snapshot.data as dynamic).docs[index]
                                    ['photoUrl']),
                          ),
                          title: Text(
                            (snapshot.data as dynamic).docs[index]['username'],
                          ),
                        );
                      }));
                })
            : FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts').get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  }
                  return StaggeredGridView.countBuilder(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      itemCount: (snapshot.data as dynamic).docs.length,
                      itemBuilder: (context, index) => Image.network(
                          (snapshot.data as dynamic).docs[index]['postUrl']),
                      staggeredTileBuilder: (index) => StaggeredTile.count(
                            (index % 7 == 0) ? 2 : 1,
                            (index % 7 == 0) ? 2 : 1,
                          ));
                }));
  }
}
