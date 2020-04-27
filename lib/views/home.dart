import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsxflutter/helper/data.dart';
import 'package:newsxflutter/helper/news.dart';
import 'package:newsxflutter/model/article_model.dart';
import 'package:newsxflutter/model/category_model.dart';
import 'package:newsxflutter/views/article_views.dart';
import 'package:newsxflutter/views/company_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

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
          centerTitle: true,
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
        child: Stack(
          // use of stack data structure  [relative layout]
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                // for saving the cached image in the device to avoid net
                imageUrl: imageURL,
                height: 100.0,
                width: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 100.0,
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Text(
                categoryname,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
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
