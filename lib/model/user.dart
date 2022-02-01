import 'package:flutter/material.dart';

class User {
  final String title, urlImage;

  const User({
    required this.title,
    required this.urlImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      title: json['title'],
      urlImage: json['urlImage']);

  Map<String, dynamic> toJson() => {

        'title': title,
        'urlImage': urlImage,
      };
}
