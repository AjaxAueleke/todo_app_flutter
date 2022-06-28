import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/models/tasks.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  String? _newTask;
  Box? _box;
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
      body: _taskView(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _listView() {
    List tasks = _box!.values.toList();
    return ListView.builder(
      itemBuilder: (BuildContext ctx, int n) {
        var task = Task.fromMap(tasks[n]);
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
                decoration: task.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          subtitle: Text(
            task.timestamp.toString(),
          ),
          trailing: Icon(
            task.done
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank,
            color: Colors.red,
          ),
        );
      },
      itemCount: tasks.length,
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: _displayPopUp,
      child: const Icon(
        Icons.add,
      ),
    );
  }

  void _displayPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext _ctx) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            onSubmitted: (value) {},
            onChanged: (value) {
              setState(
                () {
                  _newTask = value;
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _taskView() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext _ctx, AsyncSnapshot _snapshot) {
        if (_snapshot.connectionState == ConnectionState.done) {
          _box = _snapshot.data;
          return _listView();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
