import 'package:flutter/material.dart';

import 'gsheets_api/gsheets_api.dart';
import 'gsheets_api/model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SheetsApi.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('GSheet Poc')),
        body: Center(
          child: Column(
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
                  //insertTwoUsers();
                },
                child: Text('Add 2 users'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
