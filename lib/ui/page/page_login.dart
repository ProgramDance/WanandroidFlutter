
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:wanandroid/event/events.dart';
import 'package:wanandroid/http/api.dart';
import 'package:wanandroid/manager/app_manager.dart';
import 'package:wanandroid/ui/page/page_register.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _pwdNode = new FocusNode();
  String _username;
  String _password;
  bool _isObscure = true;
  Color _pwdIconColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: <Widget>[
            _buildUserName(),
            _buildPwd(),
            _buildLogin(),
            _buildRegister()
          ],
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: '用户名',
      ),
      initialValue: _username,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_pwdNode);
      },
      validator: (String value) {
        if (value.trim().isEmpty) {
          return '请输入用户名';
        }
        _username = value;
      },
    );
  }

  Widget _buildPwd() {
    return TextFormField(
      focusNode: _pwdNode,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.trim().isEmpty) {
          return '请输入密码';
        }
        _password = value;
      },
      textInputAction: TextInputAction.done,
      onEditingComplete: _doLogin,
      decoration: InputDecoration(
          labelText: '密码',
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: _pwdIconColor,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
                _pwdIconColor = _isObscure
                    ? Colors.grey
                    : Theme.of(context).iconTheme.color;
              });
            },
          )),
    );
  }

  Widget _buildLogin() {
    return Container(
      height: 45.0,
      margin: EdgeInsets.only(top: 18.0, left: 8.0, right: 8.0),
      child: RaisedButton(
        child: Text(
          '登录',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: _doLogin,
      ),
    );
  }

  Widget _buildRegister() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('没有账号？'),
          GestureDetector(
            child: Text(
              '点击注册',
              style: TextStyle(color: Colors.green),
            ),
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return RegisterPage();
              }));
            },
          )
        ],
      ),
    );
  }

  void _doLogin() async {
    _pwdNode.unfocus();

    if (_formKey.currentState.validate()) {
      debugPrint("_doLogin>>login start");
      var result = await Api.login(_username, _password);
      debugPrint("_doLogin>>login finish");
      debugPrint("_doLogin$result");
      if (result['errorCode'] == -1) {
        Toast.show(result['errorMsg'], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      } else {
        debugPrint("登录成功");
        AppManager.eventBus.fire(LoginEvent(_username));
        Navigator.pop(context);
      }
    }
  }
}
