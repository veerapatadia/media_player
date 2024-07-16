import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:media_player/utils/audiodata.dart';

class AudioComponent extends StatefulWidget {
  @override
  _AudioComponentState createState() => _AudioComponentState();
}

class _AudioComponentState extends State<AudioComponent> {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  String? currentAudioPath;

  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.playlistAudioFinished.listen((e) {
      print("Audio finished: ${e.audio.assetAudioPath}");
      setState(() {
        currentAudioPath = null;
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
      if (currentAudioPath == audioPath && assetsAudioPlayer.isPlaying.value) {
        await assetsAudioPlayer.pause();
        setState(() {
          currentAudioPath = null;
        });
      } else {
        await assetsAudioPlayer.open(
          Audio(audioPath),
          autoStart: true,
          showNotification: true,
        );
        setState(() {
          currentAudioPath = audioPath;
        });
      }
    } catch (error) {
      print("Error playing audio: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: popularItems
                  .map(
                    (e) => Card(
                      elevation: 3,
                      color: Colors.grey.shade600,
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('detail_page', arguments: e);
                        },
                        leading: Container(
                          color: Colors.transparent,
                          width: 70,
                          height: 70,
                          child: Image.network(
                            "${e['imagePath']}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          "${e['title']}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          "${e['artist']}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            playAudio(e['audioPath']);
                          },
                          icon: Icon(
                            currentAudioPath == e['audioPath'] &&
                                    assetsAudioPlayer.isPlaying.value
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
