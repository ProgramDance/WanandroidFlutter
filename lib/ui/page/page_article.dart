import 'package:banner_view/banner_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/http/api.dart';
import 'package:wanandroid/ui/page/page_webview.dart';
import 'package:wanandroid/ui/widget/article_item.dart';

class ArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ArticleState();
}

class _ArticleState extends State {
  /// 滑动控制器
  ScrollController _controller = new ScrollController();

  /// 控制正在加载的显示
  bool _isHide = true;

  /// 请求到的文章数据
  List articles = [];

  /// banner图
  List banners = [];

  ///分页加载，当前页码
  int curPage = 0;

  /// 文章总数
  int totalCount = 0;

  @override
  void initState() {
    debugPrint('initState');
    super.initState();
    _controller.addListener(() {
      /// 可滚动最大范围
      var maxScroll = _controller.position.maxScrollExtent;

      /// 当前位置的像素值
      var pixels = _controller.position.pixels;

      debugPrint("initState>>curPage:$curPage,totalCount:$totalCount");

      /// 当前滑动位置到达底部，同时还有更多数据
      if (maxScroll == pixels && curPage < totalCount) {
        /// 加载更多
        _getArticlelist();
      }
    });
    _pullToRefresh();
  }

  // 布局
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        // 正在加载
        Offstage(
          offstage: !_isHide,
          child: new Center(child: new CircularProgressIndicator()),
        ),

        // 内容
        Offstage(
          offstage: _isHide,
          child: new RefreshIndicator(
              child: ListView.builder(
                //条目数 +1代表了banner的条目
                itemCount: articles.length + 1,
                itemBuilder: (context, i) => _buildItem(i),
                controller: _controller,
              ),
              onRefresh: _pullToRefresh),
        )
      ],
    );
  }

  Widget _buildItem(int i) {
    debugPrint('_buildItem');

    // banner
    if (i == 0) {
      return new Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: _bannerView(),
      );
    }

    var itemData = articles[i - 1];
    return new ArticleItem(itemData);
  }

  Widget _bannerView() {
    //map:转换 ,将List中的每一个条目执行 map方法参数接收的这个方法,这个方法返回T类型，
    //map方法最终会返回一个  Iterable<T>
    List<Widget> list = banners.map((item) {
      return InkWell(
        child: Image.network(item['imagePath'], fit: BoxFit.cover), //fit 图片充满容器
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return WebViewPage(item);
          }));
        },
      );
    }).toList();
    return list.isNotEmpty
        ? BannerView(
            list,
            //控制轮播时间
            intervalDuration: const Duration(seconds: 3),
          )
        : null;
  }

  ///下拉刷新
  Future<void> _pullToRefresh() async {
    debugPrint('_pullToRefresh');
    curPage = 0;
    Iterable<Future> futures = [_getArticlelist(), _getBanner()];
    await Future.wait(futures);
    _isHide = false;
    setState(() {});
    return null;
  }

  _getArticlelist([bool update = true]) async {
    debugPrint('_getArticlelist');
    var data = await Api.getArticleList(curPage);
    if (data != null) {
      debugPrint("_getArticlelist>>data:$data");
      var map = data['data'];
      var datas = map['datas'];
      totalCount = map['pageCount'];

      if (curPage == 0) {
        articles.clear();
      }
      curPage++;
      articles.addAll(datas);

      ///更新ui
      if (update) {
        setState(() {
          debugPrint('_getArticlelist update');
        });
      }
    }
  }

  _getBanner([bool update = true]) async {
    var data = await Api.getBanner();
    if (data != null) {
      banners.clear();
      banners.addAll(data['data']);
      if (update) {
        setState(() {});
      }
    }
  }
}
