
import 'package:flutter/material.dart';
import 'package:wanandroid/ui/page/page_webview.dart';

class CollectArticleItem extends StatelessWidget {
  final itemData;

  const CollectArticleItem(this.itemData);

  @override
  Widget build(BuildContext context) {
    Text title = Text(
      itemData['title'],
      style: TextStyle(fontSize: 16, color: Colors.black),
      textAlign: TextAlign.left,
    );
    Text time = Text(
      DateTime.fromMicrosecondsSinceEpoch(itemData['publishTime']).toString(),
      style: TextStyle(fontSize: 12, color: Colors.grey),
      textAlign: TextAlign.left,
    );

    Column colum = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: title,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: time,
        )
      ],
    );

    return Card(
      ///阴影效果
      elevation: 2.0,
      child: InkWell(
        child: colum,
        onTap: (){
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            itemData['url'] = itemData['link'];
            return WebViewPage(itemData);
          }));
        },
      ),
    );
  }
}
