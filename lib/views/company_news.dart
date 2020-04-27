import 'package:flutter/material.dart';
import 'package:newsxflutter/helper/news.dart';
import 'package:newsxflutter/model/article_model.dart';

import 'article_views.dart';

class company_news extends StatefulWidget {
  final String category;
  company_news({this.category});

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
            Text("Flutter"),
            Text(
              "News",
              style: TextStyle(
                color: Colors.redAccent,
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
                        physics:
                            ClampingScrollPhysics(), // VM : for scrolling in vertical direction
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            desp: articles[index].description,
                            url: articles[index].url,
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
  final String imageUrl, title, desp, url;

  BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desp,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => article_views(
                      blogURL: url,
                    )));
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
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Text(
                desp,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          )),
    );
  }
}
