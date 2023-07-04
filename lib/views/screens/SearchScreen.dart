import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidscroll_app/models/user.dart';

import '../../constant/TextService.dart';
import '../../controllers/SearchController.dart';
import 'ProfileScreen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Color.fromARGB(255, 230, 224, 224),
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    suffixIcon: Icon(
                      Icons.mic,
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.only(left: 10),
                    border: InputBorder.none,
                    filled: false,
                    hintText: 'Bob Marley',
                    hintStyle: TextService.mediumText
                        .copyWith(fontSize: 16, color: Colors.black26),
                  ),
                  onFieldSubmitted: (value) =>
                      searchController.searchUser(value),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0, top: 5),
                child: InkWell(
                  onTap: () {
                    _searchController(String value) {
                      searchController.searchUser(value);
                    }
                  },
                  child: Center(
                    child: Text('Search',
                        style: TextService.mediumText
                            .copyWith(fontSize: 15, color: Colors.red)),
                  ),
                ),
              )
            ],
          ),
          body: searchController.searchedUsers.isEmpty
              ? Center(
                  child: Text(
                    'Search for users!',
                    style: TextService.mediumText.copyWith(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: ListView.builder(
                      itemCount: searchController.searchedUsers.length,
                      itemBuilder: (context, index) {
                        User user = searchController.searchedUsers[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                  uid: user.uid,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                user.profilePhoto,
                              ),
                            ),
                            title: Text(
                              user.name,
                              style: TextService.mediumText.copyWith(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                ));
    });
  }
}
