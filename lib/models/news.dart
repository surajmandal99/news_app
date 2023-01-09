import 'package:http/http.dart' as http;
import 'dart:convert';

import 'article.dart';

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    final response = await http.get(Uri.parse(
        'http://newsapi.org/v2/top-headlines?country=us&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=25afaecc9c384f6f8e76281420220295'));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
              title: element["title"],
              author: element['author'],
              published: DateTime.parse(element['publishedAt']),
              imgUrl: element['urlToImage'],
              content: element['content'],
              description: element['description'],
              articleUrl: element['url']);
          news.add(article);
        }
      });
    }
  }
}

class CategoryNews {
  List<Article> news = [];

  Future<void> getCategoryNews(String category) async {
    final response = await http.get(Uri.parse(
        'http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=25afaecc9c384f6f8e76281420220295'));

    // var jsonData = jsonDecode(response.body);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
              title: element['title'],
              author: element['author'],
              published: DateTime.parse(element['publishedAt']),
              imgUrl: element['urlToImage'],
              content: element['content'],
              articleUrl: element['url'],
              description: element['description']);
          news.add(article);
        }
      });
    }
  }
}
