import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
//
import 'package:flutter_news/constants.dart';
import 'dart:convert';

//
class ArticleInfo {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime datePublished;
  //
  ArticleInfo({
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.urlToImage,
    @required this.datePublished,
  });
  //
  ArticleInfo.fromJson({Map<String, dynamic> json})
      : author = json['author'],
        title = json['title'],
        description = json['description'],
        url = json['url'],
        urlToImage = json['urlToImage'],
        datePublished = json['datePublished'];
}

class ArticleStore with ChangeNotifier {
  // list of articles property
  List<ArticleInfo> articlesList = [];
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  int get count => articlesList.length;
  bool _foundError = false;
  bool get foundError => _foundError;
  //
  ArticleStore({@required String searchFor}) {
    fetchArticles(searchFor: searchFor);
  }
  //
  Future<void> fetchArticles({
    String searchFor = 'flutter',
  }) async {
    final fullApiUrl = Constants.shared.apiUrl(searchFor: searchFor);
    //
    _isFetching = true;
    _foundError = false;
    notifyListeners();
    // Helper.debug('Starting http fetch of URL $fullApiUrl');
    final response = await http.get(fullApiUrl);
    // Helper.debug('Completed http fetch of URL $fullApiUrl');
    if (response.statusCode != 200) {
      // found an error
      _foundError = true;
      _isFetching = false;
      return;
    }
    final resultAsJson = jsonDecode(response.body) as Map<String, dynamic>;
    _buildArticleList(json: resultAsJson);
    _isFetching = false;
    notifyListeners();
    //
  }

  void _buildArticleList({
    Map<String, dynamic> json,
  }) {
    final articlesAsJson = json['articles'] as List<dynamic>;
    articlesList = [];
    articlesAsJson.forEach((articleJson) {
      articlesList.add(ArticleInfo.fromJson(json: articleJson as Map<String, dynamic>));
    });
  }

  //
  List<ArticleInfo> articlesByAuthor({@required String author}) {
    return articlesList.where((article) => article.author.toLowerCase() == author.toLowerCase()).toList();
  }
}
