import 'package:audio_video_player/screens/audio/audio_screen.dart';
import 'package:audio_video_player/screens/video/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  
  late final _routes = const [
    AudioPage(),
    VideoPage(),
  ];
  int _pilihtabbar = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions =[
    Text(
      'Music',
      style: optionStyle,
    ),
    Text(
      'Video',
      style: optionStyle,
    ),
  ];

  void _changetabbar(int index) {
    setState(() {
      _pilihtabbar = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes[_pilihtabbar],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xfff2f2f2),
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(4, 0),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Music',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_collection),
              label: 'Video',
            ),
          ],
          currentIndex: _pilihtabbar,
          selectedItemColor: Colors.green[300],
          onTap: _changetabbar,
        ),
      )
    );
  }
}

