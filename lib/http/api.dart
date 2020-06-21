import 'package:dio/dio.dart';
import 'package:wanandroid/http/http_manager.dart';

class Api {
  static const String baseUrl = "https://www.wanandroid.com/";
  static const String ARTICLE_LIST = "article/list/";
  static const String BANNER = "banner/json";

  //登录
  static const String LOGIN = "user/login";

  //注册
  static const String REGISTER = "user/register";

  //退出
  static const String LOGOUT = "user/logout/json";

  //收藏
  static const String COLLECT = "lg/collect/list/";

  static getArticleList(int page) async {
    return HttpManager.getInstance().request('$ARTICLE_LIST$page/json');
  }

  static getCollectArticle(int page) async{
    return HttpManager.getInstance().request('$COLLECT$page/json');
  }

  static getBanner() async {
    return await HttpManager.getInstance().request(BANNER);
  }

  static login(String username, String password)  async {
    var formData = FormData.from({
      "username": username,
      "password": password,
    });
    return await HttpManager.getInstance()
        .request(LOGIN, data: formData, method: 'post');
  }

  static register(String username, String password) async{
    var formData = FormData.from({
      "username":username,
      "password":password,
      "repassword":password
    });
    return await HttpManager.getInstance()
        .request(REGISTER, data: formData, method: "post");
  }

  static clearCookie(){
    HttpManager.getInstance().clearCookie();
  }

  static getCollects(int page) async {
    return await HttpManager.getInstance().request("$COLLECT/$page/json");
  }
}
