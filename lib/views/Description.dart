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

//    return Scaffold(
//      body: (widget.imageurl == null)
//          ? CircularProgressIndicator()
//          : ListView(
//              children: <Widget>[
//                Column(children: <Widget>[
//                  Stack(
//                    children: <Widget>[
//                      Container(
//                        height: MediaQuery.of(context).size.height * 0.38,
//                        width: double.infinity,
//                        child: Image.network(widget.imageurl),
//                      ),
//                      Row(
//                        children: <Widget>[
//                          Container(
//                            alignment: Alignment.bottomRight,
//                            child: Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: IconButton(
//                                onPressed: () {
//                                  Navigator.pop(context);
//                                },
//                                icon:
//                                    Icon(Icons.arrow_back, color: Colors.white),
//                              ),
//                            ),
//                          ),
//                          Spacer(),
//                          Container(
//                            alignment: Alignment.topLeft,
//                            child: Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: IconButton(
//                                onPressed: () {
//                                  setState(() {
//                                    Share.share(widget.contentURL);
//                                  });
//                                },
//                                icon: Icon(Icons.share, color: Colors.white),
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                  Container(
//                    child: Center(
//                      child: Padding(
//                        padding: const EdgeInsets.all(5.0),
//                        child: Padding(
//                          padding: const EdgeInsets.symmetric(
//                              horizontal: 10, vertical: 6),
//                          child: Text(
//                            widget.source,
//                            style: TextStyle(
//                              fontSize: 24,
//                              fontWeight: FontWeight.bold,
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                  Container(
//                    child: Center(
//                      child: Padding(
//                        padding: const EdgeInsets.all(5.0),
//                        child: Padding(
//                          padding: const EdgeInsets.symmetric(
//                              horizontal: 10, vertical: 6),
//                          child: Text(
//                            widget.title,
//                            style: TextStyle(
//                              fontSize: 24,
//                              fontWeight: FontWeight.bold,
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                  Container(
//                    margin: EdgeInsets.all(15),
//                    child: Padding(
//                      padding: const EdgeInsets.all(3.0),
//                      child: (widget.content == null)
//                          ? Text("News Hours - Created By Tushar Nikam")
//                          : Text(
//                              widget.content,
//                              style: TextStyle(fontSize: 16),
//                            ),
//                    ),
//                  ),
//                  MaterialButton(
//                    height: MediaQuery.of(context).size.height * 0.05,
//                    minWidth: MediaQuery.of(context).size.width * 0.80,
//                    color: Colors.redAccent,
//                    onPressed: () {
//                      launch(widget.contentURL);
//                    },
//                    shape: StadiumBorder(),
//                    child: Text(
//                      "Read Full News",
//                      style: TextStyle(color: Colors.white),
//                    ),
//                  ),
//                ]),
//              ],
//            ),
//    );
