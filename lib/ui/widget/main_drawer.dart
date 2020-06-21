import 'package:flutter/material.dart';
import 'package:wanandroid/event/events.dart';
import 'package:wanandroid/http/api.dart';
import 'package:wanandroid/manager/app_manager.dart';
import 'package:wanandroid/ui/page/page_collect.dart';
import 'package:wanandroid/ui/page/page_login.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainDrawerState();
  }
}

class _MainDrawerState extends State<MainDrawer> {
  String _username;

  @override
  void initState() {
    super.initState();
    // 监听特定的事件：LoginEvent
    AppManager.eventBus.on<LoginEvent>().listen((event) {
      debugPrint("收到登录成功消息");
      setState(() {
        _username = event.username;
        // sp保存
        AppManager.prefs.setString(AppManager.ACCOUNT, _username);
      });
    });
    _username = AppManager.prefs.getString(AppManager.ACCOUNT);
  }

  @override
  Widget build(BuildContext context) {
    Widget userHeader = DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: InkWell(
        ///
        onTap: () => _itemClick(null),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 18.0),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo.png"),
                radius: 38.0,
              ),
            ),
            Text(
              _username ?? "请先登录",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            )
          ],
        ),
      ),
    );
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        /// 头部
        userHeader,

        /// 收藏
        InkWell(
          child: ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              '收藏列表',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          onTap: goCollect,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
          child: Divider(
            color: Colors.grey,
          ),
        ),

        /// 退出登录
        Offstage(
          offstage: _username == null,
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              '退出登录',
              style: TextStyle(fontSize: 16.0),
            ),
            onTap: () {
              setState(() {
                AppManager.prefs.setString(AppManager.ACCOUNT, null);
                Api.clearCookie();
                _username = null;
              });
            },
          ),
        )
      ],
    );
  }

  _itemClick(Widget page) {
    var dstPage = _username == null ? LoginPage() : page;
    if (dstPage != null) {
      Navigator.push(context, new MaterialPageRoute(builder: (context) {
        return dstPage;
      }));
    }
  }

  void goCollect() {
    if (_username == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return CollectPage();
      }));
    }
  }
}
