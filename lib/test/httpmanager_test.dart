import 'package:flutter/material.dart';

import 'package:aiweibo/core/net/httpmanager.dart';
import 'package:aiweibo/core/net/weiboapi.dart';

///
/// @author MichaelChou
/// @date 2018/11/4 2:54 PM
///

void main() {
  runApp(new TestHttpManagerApp());
}

class TestHttpManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'HttpManager Test',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('test'),
        ),
        body: new Column(
          children: <Widget>[
            new RaisedButton(
              onPressed: () {
                HttpManager.send(WeiBoApi.getAuthorize());
              },
              child: new Text('HttpManager Auth'),
            ),
          ],
        ),
      ),
    );
  }

}