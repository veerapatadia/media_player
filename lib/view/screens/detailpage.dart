import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  String? currentAudioPath;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.playlistAudioFinished.listen((e) {
      print("Audio finished: ${e.audio.assetAudioPath}");
      setState(() {
        currentAudioPath = null;
        isPlaying = false;
      });
    });

    assetsAudioPlayer.isPlaying.listen((playing) {
      setState(() {
        isPlaying = playing;
      });
    });
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  void playAudio(String audioPath) async {
    try {
      if (currentAudioPath == audioPath && isPlaying) {
        await assetsAudioPlayer.pause();
        setState(() {
          currentAudioPath = null;
          isPlaying = false;
        });
      } else {
        await assetsAudioPlayer.open(
          Audio(audioPath),
          autoStart: true,
          showNotification: true,
        );
        setState(() {
          currentAudioPath = audioPath;
          isPlaying = true;
        });
      }
    } catch (error) {
      print("Error playing audio: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> song =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      //backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text("Music"),
        // backgroundColor: Colors.purple[800],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                song['imagePath'] ?? '',
                height: 300,
                width: 350,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 50),
            Text(
              song['title'] ?? '',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                // color: Colors.black87,
              ),
            ),
            Text(
              song['artist'] ?? '',
              style: TextStyle(
                fontSize: 18,
                //color: Colors.black54,
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: assetsAudioPlayer.currentPosition,
              builder: (context, snapshot) {
                Duration? data = snapshot.data;
                String currentPosition = data.toString();
                return StreamBuilder(
                  stream: assetsAudioPlayer.current,
                  builder: (context, ss) {
                    Playing? playing = ss.data;
                    Duration? totalDuration = playing?.audio.duration;
                    return Column(
                      children: [
                        Slider(
                          value: (data == null) ? 0 : data.inSeconds.toDouble(),
                          min: 0,
                          max: (totalDuration == null)
                              ? 0
                              : totalDuration.inSeconds.toDouble(),
                          onChanged: (val) {
                            assetsAudioPlayer
                                .seek(Duration(seconds: val.toInt()));
                          },
                          activeColor: Colors.purple[100],
                          inactiveColor: Colors.purple[100],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentPosition != null
                                  ? "${currentPosition.toString().split(".")[0]}"
                                  : "0:00:00",
                            ),
                            Text(
                              totalDuration != null
                                  ? "${totalDuration.toString().split(".")[0]}"
                                  : "0:00:00",
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  //color: Colors.purple[800],
                  iconSize: 36,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    currentAudioPath == song['audioPath'] && isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  //color: Colors.purple[800],
                  iconSize: 45,
                  onPressed: () {
                    playAudio(song['audioPath'] ?? '');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  // color: Colors.purple[800],
                  iconSize: 36,
                  onPressed: () {},
                ),
              ],
            ),
            // SizedBox(height: 20),
            // IconButton(
            //   icon: Icon(Icons.favorite),
            //   color: Colors.pinkAccent,
            //   iconSize: 30,
            //   onPressed: () {
            //     // Implement favorite functionality here
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
