import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  _HomePage();
  @override
  Widget build(BuildContext ctx) {
    _deviceHeight = MediaQuery.of(ctx).size.height;

    _deviceWidth = MediaQuery.of(ctx).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 100,
        title: const Text(
          'Taskly',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),
        ),
        toolbarHeight: _deviceHeight! * 0.20,
      ),
      body: _listView(),
    );
  }

  Widget _listView() {
    return ListView(
      children: [
        ListTile(
          title: Text('Do stuff'),
        ),
      ],
    );
  }
}
