import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wanandroid/http/api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path/path.dart';

class HttpManager {
  Dio _dio;
  static HttpManager _instance;
  PersistCookieJar _persistCookieJar;

  factory HttpManager.getInstance() {
    if (null == _instance) {
      _instance = new HttpManager.Internal();
    }
    return _instance;
  }

  // 下面是命名构造方法
  HttpManager.Internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: Api.baseUrl,
      connectTimeout: 10000, // 连接超时
      receiveTimeout: 10000, // 读取超时
    );
    _dio = new Dio(options);

    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print(
          "\n================================= 请求数据 =================================");
      print("method = ${options.method.toString()}");
      print("url = ${options.uri.toString()}");
      print("headers = ${options.headers}");
      print("params = ${options.queryParameters}");
      print("data = ${options.data}");
    }, onResponse: (Response response) {
      print(
          "\n================================= 响应数据开始 =================================");
      print("code = ${response.statusCode}");
      print("data = ${response.data}");
      print(
          "================================= 响应数据结束 =================================\n");
    }, onError: (DioError e) {
      print(
          "\n=================================错误响应数据 =================================");
      print("type = ${e.type}");
      print("message = ${e.message}");
      print("stackTrace = ${e.stackTrace}");
      print("\n");
    }));

    _initDio();
  }

  request(url, {data, String method = 'get'}) async {
    try {
      Options options = new Options(method: method);
      print(options.toString());
      Response response = await _dio.request(url, data: data, options: options);
      print(response.request.headers);
      print(response.data);
      return response.data;
    } catch (e) {
      print("request e:$e.toString()");
      return null;
    }
  }

  void _initDio() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var path = Directory(join(directory.path, "cookie")).path;
    _persistCookieJar = PersistCookieJar(dir: path);
    _dio.interceptors.add(CookieManager(_persistCookieJar));
  }

  void clearCookie() {
    _persistCookieJar.deleteAll();
  }
}
