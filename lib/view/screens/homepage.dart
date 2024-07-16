import 'package:flutter/material.dart';
import 'package:media_player/view/component/audiocomponent.dart';
import 'package:media_player/view/component/carouselcomponent.dart';
import 'package:media_player/view/component/videocomponent.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "V Music",
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: "All",
              //icon: Icon(Icons.apps),
            ),
            Tab(
              text: "Music",
              // icon: Icon(Icons.surround_sound_outlined),
            ),
            Tab(
              text: "Video",
              //icon: Icon(Icons.video_camera_back_outlined),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CarouselComponent(),
          AudioComponent(),
          VideoComponent(),
        ],
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {
      //         if (tabController.index > 0) {
      //           setState(() {
      //             tabController.index = tabController.index - 1;
      //           });
      //         }
      //       },
      //       mini: true,
      //       child: Icon(Icons.arrow_back_ios),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         if (tabController.index < tabController.length - 1) {
      //           setState(() {
      //             tabController.index = tabController.index + 1;
      //           });
      //         }
      //       },
      //       mini: true,
      //       child: Icon(Icons.arrow_forward_ios),
      //     ),
      //   ],
      // ),
    );
  }
}
