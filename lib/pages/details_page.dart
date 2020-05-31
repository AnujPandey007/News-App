import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class DetailsPage extends StatefulWidget {
  static const routeName = '/details';

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  WebViewController _contentWebViewCtrl;

  void _renderHtml(String url, WebViewController controller) {
    print('CC: '+url);
    controller.loadUrl(url);
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    String articleId = ModalRoute.of(context).settings.arguments;
//    print('ART: '+articleId);
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Padding(
        padding: EdgeInsets.all(3.0),
        child: Stack(
          children: <Widget>[
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (webViewController) {
                _contentWebViewCtrl = webViewController;
                _renderHtml(articleId, _contentWebViewCtrl);
              },
              onPageFinished: (_) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? Center( child: CircularProgressIndicator()) : Container(),
          ],
        ),
      ),
    );
  }

}