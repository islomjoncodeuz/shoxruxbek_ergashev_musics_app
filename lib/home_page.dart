import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoxruxbek_ergashev_musics_app/colors.dart';
import 'package:shoxruxbek_ergashev_musics_app/list_element.dart';
import 'package:shoxruxbek_ergashev_musics_app/listening_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: elements.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: ListTile(
              leading: ClipOval(
                child: Image.asset(
                  "assets/images/${elements[index]}.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              tileColor: listTileColor,
              title: Text(
                titles[index],
                style: GoogleFonts.poppins(
                  color: whiteColor,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                auther[index],
                style: GoogleFonts.poppins(color: whiteColor),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => 
                    // ListeningPage(
                    //     auther: auther[index],
                    //     imageassets: elements[index],
                    //     title: titles[index]),
                    ListeningPage(id: index,)
                  ),
                );
              },
              trailing: Icon(
                Icons.music_note,
                color: whiteColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
