import 'package:flutter/material.dart';
import 'package:flutter_news/pages/article_content.dart';
import 'package:provider/provider.dart';
//
import '../model/article_info.dart';
import '../widgets/refresh_articles_button.dart';

//
class ArticleListPage extends StatelessWidget {
  final String title;
  //
  ArticleListPage({
    Key key,
    @required this.title,
  }) : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    final articleList = Provider.of<ArticleStore>(context);
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(title + ' (' + articleList.count.toString() + ')'),
        actions: <Widget>[if (!articleList.isFetching) RefreshArticlesButton()],
      ),
      body: articleList.isFetching
          ? Center(child: CircularProgressIndicator())
          : articleList.foundError
              ? Center(
                  child: Text('Sorry, an error occurred this time'),
                )
              : ListView.separated(
                  itemCount: articleList.count,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    final article = articleList.articlesList[index];
                    //
                    return ListTile(
                      title: Text(article.title),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticleContent(
                                    title: article.title,
                                    url: article.url,
                                  ))),
                    );
                  },
                ),
    );
  }
}
