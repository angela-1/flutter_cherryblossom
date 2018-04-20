import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

import 'package:flutter_cherryblossom/detail.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;
  String _password = '';
  final TextEditingController _controller = new TextEditingController();

  bool _validPassword() {
    var bytes = utf8.encode(_controller.text);
    var digest = sha256.convert(bytes);

    print("Digest as bytes: ${digest.bytes}");
    print("Digest as hex string: $digest");

    if (digest.toString() ==
        'c128862921449c4927a344a6e5e9efc8f07bc3b8d4c00ebbd8519648255b13ee') {
      showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text('输入正确'),
              content: new Text(_controller.text),
            ),
      );
      return true;
    }
    showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
            title: new Text('输入错误'),
            content: new Text(_controller.text),
          ),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    const TextStyle _kUnderline = const TextStyle(
        color: CupertinoColors.black,
//        decoration: TextDecoration.underline,
        decorationColor: const Color(0xFF000000),
        decorationStyle: TextDecorationStyle.solid);

    return new CupertinoPageScaffold(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            child: new DefaultTextStyle(
              style: Theme.of(context).textTheme.title,
              child: new SafeArea(
                  top: false, bottom: false, child: new Text('请输入密码')),
            ),
          ),
          new Padding(
              padding: EdgeInsets.all(36.0),
              child: new Container(
                padding: EdgeInsets.all(12.0),
                child: new EditableText(
                    controller: _controller,
                    cursorColor: CupertinoColors.black,
                    focusNode: new FocusNode(),
                    style: _kUnderline),
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(6.0),
                    color: CupertinoColors.lightBackgroundGray
                ),
              ),
          ),

//          new Padding(
//              padding: EdgeInsets.all(36.0),
//              child: new EditableText(
//                  controller: _controller,
//                  cursorColor: CupertinoColors.black,
//                  focusNode: new FocusNode(),
//                  style: _kUnderline)
////              child: new TextField(
////                controller: _controller,
////                decoration: new InputDecoration(
////                  hintText: '密码',
////                ),
////              )
//              ),
          new CupertinoButton(
              child: const Text('好'),
              color: CupertinoColors.activeBlue,
              onPressed: () {
                if (_validPassword()) {
                  Navigator.of(context).push(new CupertinoPageRoute<void>(
                        builder: (BuildContext context) => new ContactsDemo(),
                      ));
                } else {
                  print('no');
                }
              }),
        ],
      ),
    );
    return new Scaffold(
//        appBar: new AppBar(
//          // Here we take the value from the MyHomePage object that was created by
//          // the App.build method, and use it to set our appbar title.
//          title: new Text(widget.title),
//        ),
        body: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          '请输入密码',
          style: new TextStyle(fontSize: 24.0),
        ),
        new Padding(
            padding: EdgeInsets.all(36.0),
            child: new TextField(
              controller: _controller,
              decoration: new InputDecoration(
                hintText: '密码',
              ),
            )),
        new RaisedButton(
          color: Colors.blue,
          onPressed: () {
            if (_validPassword()) {
              Navigator.of(context).push(new CupertinoPageRoute<void>(
                    builder: (BuildContext context) => new ContactsDemo(),
                  ));
            } else {
              print('no');
            }

//                showDialog(
//                  context: context,
//                  builder: (_) => new AlertDialog(
//                        title: new Text('What you typed'),
//                        content: new Text(_controller.text),
//                      ),
//                );
          },
          child: new Text('好'),
        ),
      ],
    ));
  }
}
