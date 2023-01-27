// import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      title: 'My Todo App',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
      ),
      // リスト一覧画面を表示
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

// リスト一覧画面用Widget
class _TodoListPageState extends State<TodoListPage> {
  List todolist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('やること一覧'),
      ),
      body: ListView.builder(
          itemCount: todolist.length + 1,
          itemBuilder: (context, index) {
            if (index != todolist.length) {
              return Card(
                child: ListTile(
                  title: Text(todolist[index]),
                ),
              );
            } else {
              return TextButton(onPressed: () {}, child: Text('aaaa'));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newListText = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return TodoAddPage();
          }));
          setState(() {
            todolist.add(newListText);
          });
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          //   return TodoAddPage();
          // }));
        },
        child: Icon(Icons.add),
      ),
    );
    // @override
  }
}

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

// リスト追加画面用Widget
class _TodoAddPageState extends State<TodoAddPage> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リストに追加する。'),
      ),
      body: Container(
          padding: EdgeInsets.all(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_text),
              TextField(
                onChanged: (String value) {
                  setState(() {
                    _text = value;
                  });
                  // _text = value;
                },
              ),
              Container(
                // color: Colors.red,
                // color: Colors.red,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop(_text);
                  },
                  child: Text('追加する。'),
                ),
              )
            ],
          )),
    );
  }
}

// class _TodoAddPageState extends State<TodoAddPage>{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//
//   }
//
// }

// class Notify {
// TodoListPage()
// }
