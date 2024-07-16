import 'dart:async';

import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushNamed("home_page");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment(0, 0.85),
        children: [
          Center(
            child: Image.network(
                "https://scontent.fraj2-1.fna.fbcdn.net/v/t39.30808-6/295031322_483494500445231_3193719446286486132_n.png?_nc_cat=103&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=7Hu6CR-H9KYQ7kNvgEOZV_I&_nc_ht=scontent.fraj2-1.fna&oh=00_AYB7xmNDUtw4sPjpKjP5Pgi037VHJeioBdBNqwNEnB0RRQ&oe=669B3E36"),
          ),
          Text(
            "V Music",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
