// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() {
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'risaton.net',
      debugShowCheckedModeBanner: false,
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
  void initState() {
    super.initState();
    // _initializePlatformSpecifics();
    // _showNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('やること一覧'),
      ),
      body: GridView.count(
        crossAxisCount: 1,
        // semanticChildCount: 2,
        children: [
          ListView.builder(

              //     }
              //     // if (index == 1) {
              //     // return Text('aaaaa');
              //     // }
              //   },
              // ),
              // ListView.builder(
              itemCount: todolist.length + 2,
              itemBuilder: (context, index) {
                if (index != todolist.length) {
                  return Card(
                    child: ListTile(
                      title: Text(todolist[index]),
                    ),
                  );
                } else if (index == todolist.length) {
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
                } else if (index == todolist.length) {
                  return ElevatedButton(
                      onPressed: () {
                        _initializePlatformSpecifics();
                        _showNotification();
                      },
                      child: Text('通知のテスト', style: TextStyle(fontSize: 26)));
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

void _initializePlatformSpecifics() {
  var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true);
  var initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS, macOS: initializationSettingsIOS);

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse res) {
    debugPrint('payload:${res.payload}');
  });
}

Future<void> _showNotification() async {
  var iosChannelSpecifics = DarwinNotificationDetails();

  var platformChannelSpecifics = NotificationDetails(
      iOS: iosChannelSpecifics, macOS: DarwinNotificationDetails());

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'risaton.net', // Notification Title
    '通知のテストです！', // Notification Body, set as null to remove the body
    platformChannelSpecifics,
    payload: 'New Payload', // Notification Payload
  );
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
