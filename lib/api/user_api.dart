import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:search_user_test/model/user.dart';

class UserApi {
  static Future<List<User>> getUsers(String query) async {
    final url = Uri.parse(
        'https://gist.githubusercontent.com/JohannesMilke/d53fbbe9a1b7e7ca2645db13b995dc6f/raw/eace0e20f86cdde3352b2d92f699b6e9dedd8c70/books.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => User.fromJson(json)).where((user) {
        final titleLower = user.title.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
