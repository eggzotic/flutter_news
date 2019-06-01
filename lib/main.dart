import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import 'pages/article_list_page.dart';
import 'model/article_info.dart';

void main() => runApp(FlutterNews());

class FlutterNews extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News 4 u',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: ChangeNotifierProvider<ArticleStore>(
        builder: (context) => ArticleStore(searchFor: 'flutter'),
        child: ArticleListPage(title: 'Flutter News 4 u'),
      ),
    );
  }
}
