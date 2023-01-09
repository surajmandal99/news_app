import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetail extends StatefulWidget {
  final String postUrl;

  const ArticleDetail({required this.postUrl});
  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.bookmark_border)),
          Container(
              padding: const EdgeInsets.all(10), child: const Icon(Icons.share))
        ],
        centerTitle: true,
        title: const Text(
          'DailyNews',
          style: TextStyle(fontSize: 25),
        ),
        elevation: 0.0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // child: WebView(
        //   initialUrl: widget.postUrl,
        //   onWebViewCreated: (WebViewController webViewController) {
        //     _controller.complete(webViewController);
        //   },
        // ),
      ),
    );
  }
}
