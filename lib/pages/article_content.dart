import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

//
class ArticleContent extends StatefulWidget {
  final String title;
  final String url;
  //
  ArticleContent({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  @override
  _ArticleContentState createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  //
  bool _loading;
  //
  @override
  void initState() {
    super.initState();
    //
    _loading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        actions: <Widget>[
          if (_loading)
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8.0,
              ),
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
        ],
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        // allow the user to navigate
        navigationDelegate: (navRequest) => NavigationDecision.navigate,
        onPageFinished: (text) => setState(() => _loading = false),
      ),
    );
  }
}
