import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Description extends StatefulWidget {
  var imageurl, title, content, contentURL, source;

  Description(
      this.imageurl, this.title, this.content, this.contentURL, this.source);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "NewsUp",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      letterSpacing: .5,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    Share.share(widget.contentURL);
                  });
                },
                icon: Icon(
                  Icons.share,
                  size: 22,
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
        body: Column(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(widget.imageurl)),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.source,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        letterSpacing: .5,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        letterSpacing: .5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 14),
                Container(
                  child: (widget.content == null)
                      ? Text(
                          "For more info read the full News!",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                letterSpacing: .5,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      : Text(
                          widget.content,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                letterSpacing: .5,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          MaterialButton(
            height: MediaQuery.of(context).size.height * 0.05,
            minWidth: MediaQuery.of(context).size.width * 0.80,
            color: Colors.blueAccent,
            onPressed: () {
              launch(widget.contentURL);
            },
            shape: StadiumBorder(),
            child: Text(
              "Read Full News",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    letterSpacing: .5,
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ]));
  }
 }
