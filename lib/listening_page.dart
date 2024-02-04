import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoxruxbek_ergashev_musics_app/colors.dart';
import 'package:shoxruxbek_ergashev_musics_app/list_element.dart';

class ListeningPage extends StatefulWidget {
  const ListeningPage({
    super.key,
    // required this.auther,
    // required this.imageassets,
    // required this.title
    required this.id,
  });
  // final String imageassets;
  // final String auther;
  final int id;
  // final String title;
  @override
  State<ListeningPage> createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage> {
  final player = AudioPlayer();

  IconData play = Icons.play_arrow;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int musicindex = widget.id;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        title: Text(
          "Shoxruxbek Ergashev",
          style: GoogleFonts.poppins(
            color: whiteColor,
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData(color: whiteColor),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/${elements[musicindex]}.jpg",
                  width: 350,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              titles[musicindex],
              style: GoogleFonts.poppins(color: whiteColor, fontSize: 22),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                auther[musicindex],
                style: GoogleFonts.poppins(color: whiteColor, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) {
                final position = Duration(seconds: value.toInt());
                player.seek(position);
                player.resume();
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    formatTime(position.inSeconds),
                    style: GoogleFonts.poppins(color: whiteColor, fontSize: 18),
                  ),
                  Text(
                    formatTime((duration - position).inSeconds),
                    style: GoogleFonts.poppins(color: whiteColor, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: listTileColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            player.stop();
                            play = Icons.play_arrow;
                          });
                        },
                        icon: Icon(
                          Icons.skip_previous,
                          color: whiteColor,
                          size: 35,
                        )),
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: listTileColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          if (player.state == PlayerState.playing) {
                            play = Icons.play_arrow;
                            player.pause();
                          } else {
                            play = Icons.pause;
                            player.play(AssetSource(
                                "audio/${elements[musicindex]}.mp3"));
                          }
                          setState(() {});
                        },
                        icon: Icon(
                          play,
                          color: whiteColor,
                          size: 35,
                        )),
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: listTileColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            player.stop();
                            play = Icons.play_arrow;
                          });
                        },
                        icon: Icon(
                          Icons.skip_next,
                          color: whiteColor,
                          size: 35,
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
