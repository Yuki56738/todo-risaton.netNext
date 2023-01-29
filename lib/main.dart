// import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'risaton.net',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List todolist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('やること一覧'),
      ),
      body: GridView.count(
        crossAxisCount: 1,
        children: [

          ListView.builder(
              itemCount: todolist.length + 1,
              itemBuilder: (context, index) {
                if (index != todolist.length) {
                  return Card(
                    child: ListTile(
                      title: Text(todolist[index]),
                    ),
                  );
                } else {
                  return TextButton(
                      onPressed: () {
                        // todolist.clear();
                        setState(() {
                          todolist.clear();
                        });
                      },
                      child: const Text('全消去',
                          style: TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              backgroundColor: Colors.blue)));
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newListText = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return TodoAddPage();
          }));
          if (newListText != null) {
            setState(() {
              todolist.add(newListText);
            });
          }
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
                },
              ),
              Container(
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
