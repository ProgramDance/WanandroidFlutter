import 'package:flutter/material.dart';
import 'package:wanandroid/http/api.dart';
import 'package:wanandroid/ui/widget/collect_article_item.dart';

class CollectArticleTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CollectArticleTabState();
  }
}

class _CollectArticleTabState extends State {
  bool _isLoading = true;
  List articles = [];
  int curPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pullToRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: !_isLoading,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        Offstage(
          offstage: _isLoading,
          child: RefreshIndicator(
            child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return _buildItem(index);
                }),
                onRefresh: _pullToRefresh,
          ),
        )
      ],
    );
  }

  Widget _buildItem(int index) {
    var itemData = articles[index];
    return CollectArticleItem(itemData);
  }

  Future<void> _pullToRefresh() async {
    curPage = 0;
    Iterable<Future> futures = [_getCollectArticle()];
    await Future.wait(futures);
    _isLoading = false;
    setState(() {});
    return null;
  }

  _getCollectArticle() async {
    var data = await Api.getCollectArticle(curPage);
    if (data != null) {
      var map = data['data'];
      var datas = map['datas'];

      if(curPage == 0){
        articles.clear();
      }
      curPage++;
      articles.addAll(datas);
      setState(() {

      });
    }
  }
}
