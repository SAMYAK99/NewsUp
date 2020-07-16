import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsxflutter/helper/data.dart';
import 'package:newsxflutter/helper/news.dart';
import 'package:newsxflutter/model/article_model.dart';
import 'package:newsxflutter/model/category_model.dart';
import 'package:newsxflutter/views/Description.dart';
import 'package:newsxflutter/views/category_news.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  //for loading
  bool _loading;

  @override
  void initState() {
    // to changing state
    _loading = true;
    super.initState();
    categories = getCategories();
    getNews();
  }

  // for getting news data
  void getNews() async {
    News news = News();
    await news.getNews();
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WidgetTitle(getStrToday()),
              IconButton(
                onPressed: () {
                  setState(() {
                    changeBrightness();
                  });
                },
                icon: Icon(
                  Icons.invert_colors,
                  size: 25,
                ),
              ),
            ],
          ),
          elevation: 0.0,
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: <Widget>[
                      /// CATEGORIES
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100, // Container height
                        child: ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis
                              .horizontal, // for scrolling in horizontal direction
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              imageURL: categories[index].imageURL,
                              categoryname: categories[index].categoryName,
                            );
                          },
                        ),
                      ),

                      ///Blogs
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
                              // url: articles[index].url,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}

class CategoryTile extends StatelessWidget {
  final String imageURL, categoryname;

  CategoryTile(
      {this.imageURL, this.categoryname}); //using this to change category

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => company_news(
                      category: categoryname.toLowerCase(),
                    )));
      }, // help to onclick functions
      child: Container(
        margin: EdgeInsets.only(right: 10.0),
        height: 50,
        child: Column(
          // use of stack data structure  [relative layout]
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(imageURL),
              radius: 40,
              backgroundColor: Colors.white,
            ),
            Text(
              categoryname,
              style: GoogleFonts.poppins(
                textStyle:
                    TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
              ),
            )
          ],
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
          margin: EdgeInsets.only(bottom: 18.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(imageUrl)),
              Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      //   color: _isswitched ? Colors.black : Colors.white,
                      letterSpacing: .5,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 8),
              Text(
                desp,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      //  color: _isswitched ? Colors.black : Colors.white,
                      letterSpacing: .5,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          )),
    );
  }
}

String getStrToday() {
  var today = DateFormat().add_yMMMMd().format(DateTime.now());
  var strDay = today.split(" ")[1].replaceFirst(',', '');
  if (strDay == '1') {
    strDay = strDay + "st";
  } else if (strDay == '2') {
    strDay = strDay + "nd";
  } else if (strDay == '3') {
    strDay = strDay + "rd";
  } else {
    strDay = strDay + "th";
  }
  var strMonth = today.split(" ")[0];
  var strYear = today.split(" ")[2];
  return "$strDay $strMonth $strYear";
}

class WidgetTitle extends StatelessWidget {
  final String strToday;

  WidgetTitle(this.strToday);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'NewsUp\n',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      //      color: _isswitched ? Colors.black : Colors.white,
                      letterSpacing: .5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
              TextSpan(
                text: strToday,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      //       color: _isswitched ? Colors.black : Colors.white,
                      letterSpacing: .5,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
