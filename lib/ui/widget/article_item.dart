import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/ui/page/page_webview.dart';

class ArticleItem extends StatelessWidget {
  final itemData;

  const ArticleItem(this.itemData);

  @override
  Widget build(BuildContext context) {
    ///时间与作者
    Row author = new Row(
      children: <Widget>[
        new Expanded(
            child: Text.rich(TextSpan(children: [
          TextSpan(text: '作者：'),
          TextSpan(
              text: itemData['author'],
              style: new TextStyle(color: Theme.of(context).primaryColor))
        ]))),
        new Text(itemData['niceDate']) //时间
      ],
    );

    ///标题
    Text title = new Text(itemData['title'],
        style: new TextStyle(color: Colors.black, fontSize: 16.0),
        textAlign: TextAlign.left);

    ///章节名
    Text chapterName = new Text(
      itemData['chapterName'],
      style: new TextStyle(color: Theme.of(context).primaryColor),
    );

    Column column = new Column(
      //垂直线性布局
      crossAxisAlignment: CrossAxisAlignment.start, // 子空降左对齐
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.all(10.0),
          child: author,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: title,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: chapterName,
        )
      ],
    );

    return new Card(

        ///阴影效果
        elevation: 4.0,
        child: InkWell(
          child: column,
          onTap: () {
            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) {
              ///因为webview获取的是map的url地址，而文章数据中文章详情的key是link
              itemData['url'] = itemData['link'];
              return WebViewPage(itemData);
            }));
          },
        ));
  }
}
