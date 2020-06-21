import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'manager/app_manager.dart';
import 'ui/page/page_article.dart';
import 'ui/widget/main_drawer.dart';

void main() {
  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppManager.initApp();
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('文章'),
        ),
        drawer: Drawer(
          child: MainDrawer(),
        ),
        body: new ArticlePage(),
      ),
    );
  }
}
