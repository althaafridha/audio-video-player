import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final playeraudio = AudioPlayer();
  bool startMusic = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    playeraudio.onPlayerStateChanged.listen((event) {
      setState(() {
        startMusic = event == PlayerState.playing;
      });
    });

    playeraudio.onDurationChanged.listen((durationNew) {
      setState(() {
        duration = durationNew;
      });
    });
    playeraudio.onPositionChanged.listen((positionNew) {
      setState(() {
        position = positionNew;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    playeraudio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: AssetImage('assets/bg-sound.png'),
                    fit: BoxFit.cover,
                  ),
                ),
             ),
              const SizedBox(
                height: 40.0,
              ),
              const Text(
                'Sound Helix Sound 8',
                style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.w700, fontSize: 20),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Sound Helix',
                style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.w300, fontSize: 16),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Slider(
                        min: 0,
                        activeColor: Colors.green[300],
                        inactiveColor: Colors.grey,
                        value: position.inSeconds.toDouble(),
                        max: duration.inSeconds.toDouble(),
                        onChanged: (value) async {}),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(waktu(position).toString(), style: const TextStyle(color: Colors.white),),
                    Text(waktu(duration - position).toString(), style: const TextStyle(color: Colors.white),),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                    onPressed: () async {
                      if (startMusic) {
                        await playeraudio.pause();
                      } else {
                        String url =
                            "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3";
                        await playeraudio.play(UrlSource(url));
                      }
                    },
                    icon: Icon(
                      startMusic ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  String? waktu(Duration position) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final second = twoDigits(duration.inMinutes.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      second,
    ].join(':');
  }
}
