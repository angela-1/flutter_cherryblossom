// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:flutter_cherryblossom/account.dart';

class _AccountCategory extends StatelessWidget {
  const _AccountCategory({Key key, this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return new Container(
//      padding: const EdgeInsets.symmetric(vertical: 2.0),
      decoration: new BoxDecoration(
          border: new Border(
              bottom: new BorderSide(color: themeData.dividerColor))),
      child: new Container(
          padding: EdgeInsets.all(16.0), child: new Column(children: children)),
    );
  }
}

class _ContactCategory extends StatelessWidget {
  const _ContactCategory({Key key, this.icon, this.children}) : super(key: key);

  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return new Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: new BoxDecoration(
          border: new Border(
              bottom: new BorderSide(color: themeData.dividerColor))),
      child: new DefaultTextStyle(
        style: Theme.of(context).textTheme.subhead,
        child: new SafeArea(
          top: false,
          bottom: false,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  width: 72.0,
                  child: new Icon(icon, color: themeData.primaryColor)),
              new Expanded(child: new Column(children: children))
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountItem extends StatelessWidget {
  _AccountItem({Key key, this.label, this.icon, this.lines, this.tooltip, this.onPressed})
      : assert(lines.length > 1),
        super(key: key);

  final String label;
  final IconData icon;
  final List<String> lines;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Widget> columnChildren = lines
        .sublist(0, lines.length - 1)
        .map((String line) => new Text(line, style: themeData.textTheme.body2))
        .toList();
    columnChildren
        .add(new Text(lines.last, style: themeData.textTheme.title));

    final List<Widget> rowChildren = <Widget>[

      new Expanded(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: columnChildren))
    ];
    if (icon != null) {
      rowChildren.add(new SizedBox(
          width: 72.0,
          child: new IconButton(
              icon: new Icon(icon),
              color: themeData.primaryColor,
              onPressed: onPressed)));
    }
    return new MergeSemantics(
      child: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: rowChildren)),
    );
  }
}

class _ContactItem extends StatelessWidget {
  _ContactItem({Key key, this.icon, this.lines, this.tooltip, this.onPressed})
      : assert(lines.length > 1),
        super(key: key);

  final IconData icon;
  final List<String> lines;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Widget> columnChildren = lines
        .sublist(0, lines.length - 1)
        .map((String line) => new Text(line))
        .toList();
    columnChildren
        .add(new Text(lines.last, style: themeData.textTheme.caption));

    final List<Widget> rowChildren = <Widget>[
      new Expanded(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: columnChildren))
    ];
    if (icon != null) {
      rowChildren.add(new SizedBox(
          width: 72.0,
          child: new IconButton(
              icon: new Icon(icon),
              color: themeData.primaryColor,
              onPressed: onPressed)));
    }
    return new MergeSemantics(
      child: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: rowChildren)),
    );
  }
}

class ContactsDemo extends StatefulWidget {
  static const String routeName = '/contacts';

  @override
  ContactsDemoState createState() => new ContactsDemoState();
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class ContactsDemoState extends State<ContactsDemo> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();
//  final double _appBarHeight = 256.0;
  final double _appBarHeight = 128.0;
  final Account _account = Account.mock();


  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        platform: Theme.of(context).platform,
      ),
      child: new Scaffold(
        key: _scaffoldKey,
        body: new CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
              expandedHeight: _appBarHeight,
              pinned: _appBarBehavior == AppBarBehavior.pinned,
              floating: _appBarBehavior == AppBarBehavior.floating ||
                  _appBarBehavior == AppBarBehavior.snapping,
              snap: _appBarBehavior == AppBarBehavior.snapping,
              actions: <Widget>[
                new IconButton(
                  icon: const Icon(Icons.create),
                  tooltip: 'Edit',
                  onPressed: () {
                    _scaffoldKey.currentState.showSnackBar(const SnackBar(
                        content: const Text(
                            'This is actually just a demo. Editing isn\'t supported.')));
                  },
                ),
//                new PopupMenuButton<AppBarBehavior>(
//                  onSelected: (AppBarBehavior value) {
//                    setState(() {
//                      _appBarBehavior = value;
//                    });
//                  },
//                  itemBuilder: (BuildContext context) => <PopupMenuItem<AppBarBehavior>>[
//                    const PopupMenuItem<AppBarBehavior>(
//                        value: AppBarBehavior.normal,
//                        child: const Text('App bar scrolls away')
//                    ),
//                    const PopupMenuItem<AppBarBehavior>(
//                        value: AppBarBehavior.pinned,
//                        child: const Text('App bar stays put')
//                    ),
//                    const PopupMenuItem<AppBarBehavior>(
//                        value: AppBarBehavior.floating,
//                        child: const Text('App bar floats')
//                    ),
//                    const PopupMenuItem<AppBarBehavior>(
//                        value: AppBarBehavior.snapping,
//                        child: const Text('App bar snaps')
//                    ),
//                  ],
//                ),
              ],
              flexibleSpace: new FlexibleSpaceBar(
                title: new Text(_account.name),
                background: new Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
//                    new Image.asset(
//                      'ali_connors.jpg',
//                      package: 'flutter_gallery_assets',
//                      fit: BoxFit.cover,
//                      height: _appBarHeight,
//                    ),
                    // This gradient ensures that the toolbar icons are distinct
                    // against the background image.
                    const DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: const LinearGradient(
                          begin: const Alignment(0.0, -1.0),
                          end: const Alignment(0.0, -0.4),
                          colors: const <Color>[
                            const Color(0x60000000),
                            const Color(0x00000000)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[
                new _AccountCategory(children: <Widget>[
                  new _AccountItem(
//                    icon: Icons.message,
                    tooltip: 'Send message',
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(const SnackBar(
                          content: const Text(
                              'Pretend that this opened your SMS application.')));
                    },
                    lines: <String>[
                      '类别',
                      _account.category,
                    ],
                  ),
                  new _AccountItem(
//                    icon: Icons.message,
                    tooltip: 'Send message',
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(const SnackBar(
                          content: const Text(
                              'Pretend that this opened your SMS application.')));
                    },
                    lines: <String>[
                      '链接',
                      _account.url,
                    ],
                  ),
                  new _AccountItem(
//                    icon: Icons.message,
                    tooltip: 'Send message',
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(const SnackBar(
                          content: const Text(
                              'Pretend that this opened your SMS application.')));
                    },
                    lines: <String>[
                      '用户名',
                      _account.user,
                    ],
                  ),
                  new _AccountItem(
                    icon: Icons.content_copy,
                    tooltip: 'Send message',
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(const SnackBar(
                          content: const Text(
                              '密码已复制')));
                    },
                    lines: <String>[
                      '密码',
                      _account.password,
                    ],
                  ),
                ]),
                new _AccountCategory(
                  children: <Widget>[
                    new _AccountItem(
                      icon: Icons.message,
                      tooltip: 'Send message',
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                            content: const Text(
                                'Pretend that this opened your SMS application.')));
                      },
                      lines: <String>[
                        '电话',
                        _account.phone,
                      ],
                    ),
                    new _AccountItem(
                      icon: Icons.message,
                      tooltip: 'Send message',
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                            content: const Text(
                                'In this demo, this button doesn\'t do anything.')));
                      },
                      lines: <String>[
                        '邮箱',
                        _account.mail,
                      ],
                    ),
                  ],
                ),
                new _AccountCategory(
                  children: <Widget>[
                    new _AccountItem(
                      icon: Icons.email,
                      tooltip: 'Send personal e-mail',
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                            content: const Text(
                                'Here, your e-mail application would open.')));
                      },
                      lines: <String>[
                        '备注',
                        _account.note,
                      ],
                    ),
                    new _AccountItem(
                      icon: Icons.email,
                      tooltip: 'Send personal e-mail',
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                            content: const Text(
                                'Here, your e-mail application would open.')));
                      },
                      lines: <String>[
                        '最后修改',
                        _account.lastMod,
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
