import 'dart:async';
import 'package:flutter/material.dart';
import 'package:search_user_test/api/user_api.dart';
import 'package:search_user_test/model/user.dart';
import 'package:search_user_test/widget/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<User> users = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  Future data() async {
    final users = await UserApi.getUsers(query);
    setState(() => this.users = users);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Search Data User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearch(),
            Expanded(
              child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return buildUser(user);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search Data User',
        onChanged: searchUser,
      );

  Future searchUser(String query) async {
    final users = await UserApi.getUsers(query);
    if (!mounted) return;
    setState(() {
      this.query = query;
      this.users = users;
    });
  }

  Widget buildUser(User user) => Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: Image.network(
              user.urlImage,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            title: Text(
              user.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
}
