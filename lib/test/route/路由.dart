
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new MainRoute(),
    );
  }
}

class MainRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一个页面'),
      ),
      body: Column(
        children: <Widget>[
          Text('第一个页面'),
          RaisedButton(
            onPressed: () {
              //导航到新路由
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SecondRoute();
              }));
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
    return new Scaffold(
      appBar: AppBar(
        title: Text('第二个页面'),
      ),
      body: Column(
        children: <Widget>[
          Text('第二个页面'),
          RaisedButton(
            onPressed: () {
              //路由pop弹出
              debugPrint('返回clicked');
              Navigator.pop(context);
            },
            child: Text('返回'),
          )
        ],
      ),
    );
  }
}
