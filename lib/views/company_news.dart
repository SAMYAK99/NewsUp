import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsxflutter/helper/news.dart';
import 'package:newsxflutter/model/article_model.dart';

import 'Description.dart';

class company_news extends StatefulWidget {
  final String category;
  final bool isswitched;

  company_news({this.category, this.isswitched});

  @override
  _company_newsState createState() => _company_newsState();
}

class _company_newsState extends State<company_news> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // to changing state
    _loading = true;
    super.initState();
    getCategoryNews();
  }

  // for getting news data
  void getCategoryNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              "NewsUp",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    letterSpacing: .5,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 15.0),
                      child: ListView.builder(
                        itemCount: articles.length,
                        physics: ClampingScrollPhysics(),
                        // VM : for scrolling in vertical direction
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            desp: articles[index].description,
                            url: articles[index].url,
                            content: articles[index].content,
                            source: articles[index].source,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desp, url, content, source;

  BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desp,
      @required this.url,
      @required this.content,
      this.source});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Description(imageUrl, title, content, url, source)));
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          margin: EdgeInsets.only(bottom: 18.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(imageUrl)),
              Text(title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        letterSpacing: .5,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600),
                  )),
              SizedBox(height: 8),
              Container(
                child: (desp == null)
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
                        desp,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              letterSpacing: .5,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
              ),
            ],
          )),
    );
  }
}
