import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticalNews extends StatefulWidget {
  const ArticalNews({super.key, required this.newsUrl});
  final String newsUrl;
  @override
  _ArticalNewsState createState() => _ArticalNewsState();
}

class _ArticalNewsState extends State<ArticalNews> {
  late bool _isLoadingPage;

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }

  @override
  Widget build(BuildContext context) {
    final WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() => _isLoadingPage = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.newsUrl));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'News',
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: webViewController,
          ),
          if (_isLoadingPage)
            Container(
              alignment: FractionalOffset.center,
              child: const CircularProgressIndicator(
                backgroundColor: Colors.yellow,
              ),
            )
          else
            const SizedBox.shrink()
        ],
      ),
    );
  }
}
