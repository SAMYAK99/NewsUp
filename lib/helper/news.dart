import 'dart:convert';

import 'package:newsxflutter/model/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&apiKey=c389a548804b46509601fc86e1c3f8e1";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      // carefully extract the data
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null || element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            // saving all the data in respective format
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNews {
  List<ArticleModel> news = [];

  Future<void> getNews(String Category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$Category&apiKey=c389a548804b46509601fc86e1c3f8e1";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      // carefully extract the data
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null || element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            // saving all the data in respective format
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );

          news.add(articleModel);
        }
      });
    }
  }
}
