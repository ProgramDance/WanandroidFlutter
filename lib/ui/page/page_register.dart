
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:wanandroid/http/api.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode _userNameNode = new FocusNode();
  FocusNode _pwdNode = new FocusNode();
  FocusNode _pwd2Node = new FocusNode();

  String _username;
  String _pwd;
  String _pwd2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(22.0, 18.0, 22.0, 0.0),
          children: <Widget>[
            _buildUserName(),
            _buildPwd(),
            _buildPwd2(),
            _buildRegister()
          ],
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return TextFormField(
      focusNode: _userNameNode,
      autofocus: true,
      decoration: InputDecoration(labelText: '用户名'),
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_pwdNode);
      },
      // 校验
      validator: (String value) {
        if (value.trim().isEmpty) {
          //错误提示
          return '请输入用户名';
        }
        _username = value;
      },
    );
  }

  Widget _buildPwd() {
    return TextFormField(
      focusNode: _pwdNode,
      autofocus: true,
      decoration: InputDecoration(
        labelText: '密码',
      ),
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_pwd2Node);
      },
      validator: (String value) {
        if (value.trim().isEmpty) {
          return '请输入密码';
        }
        _pwd = value;
      },
    );
  }

  Widget _buildPwd2() {
    return TextFormField(
      focusNode: _pwd2Node,
      autofocus: true,
      decoration: InputDecoration(
        labelText: '确认密码',
      ),
      textInputAction: TextInputAction.go,
      onEditingComplete: () {
        _click();
      },
      validator: (String value) {
        if (value.trim().isEmpty) {
          return '请确认密码';
        }

        if (_pwd != value) {
          return '两次密码输入不一致';
        }
        _pwd2 = value;
      },
    );
  }

  Widget _buildRegister() {
    return Container(
      height: 52.0,
      margin: EdgeInsets.only(top: 18.0),
      child: RaisedButton(
        child:
            Text('注册', style: TextStyle(color: Colors.white, fontSize: 18.0)),
        color: Theme.of(context).primaryColor,
        onPressed: _click,
      ),
    );
  }

  void _click() async {
    _userNameNode.unfocus();
    _pwdNode.unfocus();
    _pwd2Node.unfocus();

    if (_formKey.currentState.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });

      var result = await Api.register(_username, _pwd);
      Navigator.pop(context);
      if (result['errorCode'] == -1) {
        var error = result['errorMsg'];
        Toast.show(error, context, gravity: Toast.CENTER);
      } else {
        Toast.show("注册成功!", context, gravity: Toast.CENTER);
        Navigator.pop(context);
      }
    }
  }
}
