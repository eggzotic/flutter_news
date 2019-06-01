import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import '../model/article_info.dart';

//
class RefreshArticlesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final articleList = Provider.of<ArticleStore>(context);

    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () => articleList.fetchArticles(),
    );
  }
}
