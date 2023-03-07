import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _player;
  @override
  void initState() {
    final video = YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/shorts/oGpS27qGrr0');
    _player = YoutubePlayerController(
        initialVideoId: video!,
        flags: const YoutubePlayerFlags(autoPlay: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
                children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: YoutubePlayer(
                controller: _player,
                showVideoProgressIndicator: true,
                onReady: () => debugPrint('Siap'),
                bottomActions: [
                  ProgressBar(
                    isExpanded: true,
                    colors: ProgressBarColors(
                        playedColor: Colors.green[300], handleColor: Colors.green[300]),
                  )
                ],
              ),
            ),
                ],
              ),
          ),
        ));
  }
}
