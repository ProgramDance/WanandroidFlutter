import 'dart:io';

void main() {
  DateTime dateTime = DateTime.now();
  print("main start $dateTime");
  Future.delayed(Duration(seconds: 2), () {
    return 'hello world';
  }).then((data1) {
    print(data1);
    print(new DateTime.now());
  });

  Future.wait([
    Future.delayed(Duration(seconds: 2), () {
      return 'hello';
    }),
    Future.delayed(Duration(seconds: 4), () {
      return 'world2';
    })
  ]).then((results) {
    print(results);
    print(new DateTime.now());
  });
  dateTime = DateTime.now();
  print("main finish $dateTime");

  testSync();
}

void testSync(){
  print("testSync start" + DateTime.now().toString());
  test1();
  test2();
  print("testSync finish" + DateTime.now().toString());
}

void test1() async{
  print("test1 start" + DateTime.now().toString());
  sleep(Duration(seconds: 3));
  print("test1 finish" + DateTime.now().toString());
}

void test2(){
  print("test2 start" + DateTime.now().toString());
  sleep(Duration(seconds: 3));
  print("test2 finish" + DateTime.now().toString());
}
