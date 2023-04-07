// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final storage = const FlutterSecureStorage();
List todolist = [];

void main() {
  // Map<String, String> allValues = await storage.readAll();
  // debugPrint(allValues.toString());
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  // List todolist = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'シンプルToDoアプリ risaton.net',
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
  _readAll() async {
    Map<String, String> allValues = await storage.readAll();
    debugPrint(allValues.toString());
    List fromStorageAllList = [];
    allValues.forEach((key, value) {
      fromStorageAllList.add(value);
    });
    setState(() {
      todolist.addAll(fromStorageAllList);
    });
  }

  @override
  void initState() {
    _readAll();
    // super.initState();
    // todolist.add(getAll());

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
        // maxCrossAxisExtent: 2,
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
                } else if (index == todolist.length) {
                  // return Container(
                  // return Column(children: <Widget>[
                  //   ElevatedButton(
                  //       onPressed: () {
                  //         // todolist.clear();
                  //         setState(() {
                  //           todolist.clear();
                  //         });
                  //       },
                  //       child: const Text('リストを全消去',
                  //           style: TextStyle(
                  //               fontSize: 36,
                  //               color: Colors.white,
                  //               backgroundColor: Colors.blue))),
                  return ElevatedButton(
                      onPressed: () {
                        _initializePlatformSpecifics();
                        _showNotification();
                      },
                      child: const Text('通知のテスト',
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              backgroundColor: Colors.blue)));
                }
              })
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
          if(newListText == null){
            setState(() {
              todolist.clear();
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
                  onPressed: () async {
                    // final storage = FlutterSecureStorage();
                    Map<String, String> allValues = await storage.readAll();
                    debugPrint(allValues.toString());
                    int currentValue = allValues.length + 1;
                    await storage.write(
                        key: currentValue.toString(), value: _text);
                    Navigator.of(context).pop(_text);
                  },
                  child: Text('追加する。'),
                ),
              ),
              Container(
                child: ElevatedButton(onPressed: () {
                  todolist.clear();
                  storage.deleteAll();
                  Navigator.of(context).pop(null);

                }, child: Text("全て削除する"),

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
  var initializationSettingsAndroid =
      const AndroidInitializationSettings("@mipmap/ic_launcher");
  var initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsIOS,
      android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse res) {
    debugPrint('payload:${res.payload}');
  });
}

Future<void> _showNotification() async {
  var iosChannelSpecifics = DarwinNotificationDetails();
  var androidChannelSpecifics = AndroidNotificationDetails("0", "risaton.net");

  var platformChannelSpecifics = NotificationDetails(
      iOS: iosChannelSpecifics,
      macOS: iosChannelSpecifics,
      android: androidChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'risaton.net', // Notification Title
    '通知のテストです！', // Notification Body, set as null to remove the body
    platformChannelSpecifics,
    payload: 'New Payload', // Notification Payload
  );
}
