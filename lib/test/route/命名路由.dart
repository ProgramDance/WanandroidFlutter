
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "flutter",
      // 下面这个不能和命名路由'/'重复
//      home: MainRoute(),
      routes: {
        '/': (context) => MainRoute(),
        'new_page': (context) => SecondRoute()
      },
    );
  }
}

class MainRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('第一个页面'),
      ),
      body: Column(
        children: <Widget>[
          Text('第一个页面'),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'new_page');
            },
            child: Text('进入第二个页面'),
          )
        ],
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二页'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.pop(context, '结束');
            },
            child: Text('返回'),
          )
        ],
      ),
    );
  }
}
