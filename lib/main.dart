import 'package:flutter/material.dart';
import 'package:media_player/view/screens/DetailPage.dart';
import 'package:media_player/view/screens/homepage.dart';
import 'package:media_player/view/screens/splashscreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => splashscreen(),
        'home_page': (context) => HomePage(),
        'detail_page': (context) => DetailPage(),
      },
    ),
  );
}
