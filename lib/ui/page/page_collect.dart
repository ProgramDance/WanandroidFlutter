import 'package:flutter/material.dart';
import 'package:wanandroid/ui/page/tab_collect_article.dart';

class CollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CollectPageState();
  }
}

class _CollectPageState extends State
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List tabs = ["文章", "网站"];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
  } //需要定义一个Controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('收藏'),
          bottom: TabBar(
            tabs: tabs.map((e) {
              return Tab(text: e);
            }).toList(),
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _buildTabsContent(),
        ));
  }

  List<Widget> _buildTabsContent() {
    List<Widget> tabs = [];
    tabs.add(CollectArticleTab());
    tabs.add(CollectArticleTab());
    return tabs;
  }

  @override
  // tab切换不用每次重走生命周期，进行网络请求
  bool get wantKeepAlive => true;
}
