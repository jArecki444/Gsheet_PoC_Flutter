import 'package:flutter/material.dart';

import 'gsheets_api/gsheets_api.dart';
import 'gsheets_api/model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SheetsApi.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<User> users = [];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('GSheet Poc')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
              onPressed: () async {
                final idOfNewUser = await SheetsApi.getRowCount() + 1;
                final user = User(
                  id: idOfNewUser.toString(),
                  avatarUrl: 'AvatarURL',
                  email: 'User$idOfNewUser@email.com',
                  name: 'TestUserName $idOfNewUser',
                );
                await SheetsApi.addUser([user.toJson()]);
              },
              child: Text('Add test user'),
            ),
            ElevatedButton(
              onPressed: () async {
                insertTwoUsers();
              },
              child: Text('Add 2 users'),
            ),
            ElevatedButton(
              onPressed: () async {
                final res = await SheetsApi.getUserById('1');
                if (res != null) {
                  setState(() {
                    users = [res];
                  });
                }
              },
              child: Text('Get user'),
            ),
            ElevatedButton(
              onPressed: () async {
                final res = await SheetsApi.getAllUsers();
                setState(() {
                  users = res;
                });
              },
              child: Text('Get all users'),
            ),
            if (users.isNotEmpty)
              Container(
                height: 400,
                child: Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          leading: Text(users[index].name),
                        );
                      }),
                ),
              )
          ],
        ),
      ),
    );
  }

  Future insertTwoUsers() async {
    final idOfFirstUser = await SheetsApi.getRowCount() + 1;
    final idOfSecondUser = await SheetsApi.getRowCount() + 2;

    final users = [
      User(
        id: idOfFirstUser.toString(),
        name: 'TestUserName $idOfFirstUser',
        email: 'User$idOfFirstUser@email.com',
        avatarUrl: 'AvatarURL',
      ),
      User(
        id: idOfSecondUser.toString(),
        name: 'TestUserName $idOfSecondUser',
        email: 'User$idOfSecondUser@email.com',
        avatarUrl: 'AvatarURL',
      ),
    ];

    final jsonUsers = users.map((user) => user.toJson()).toList();

    await SheetsApi.addUser(jsonUsers);
  }
}
