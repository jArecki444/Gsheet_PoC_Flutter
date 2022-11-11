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
        appBar: AppBar(title: const Text('GSheet Poc')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                child: const Text('Add test user'),
              ),
              ElevatedButton(
                onPressed: () async {
                  insertTwoUsers();
                },
                child: const Text('Add 2 users'),
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
                child: const Text('Get user'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final res = await SheetsApi.getAllUsers();
                  setState(() {
                    users = res;
                  });
                },
                child: const Text('Get all users'),
              ),
              ElevatedButton(
                onPressed: () async {
                  const updatedUser = User(
                    id: '1',
                    avatarUrl: 'AvatarURL Update',
                    email: 'User@email.com Update',
                    name: 'TestUserName Update',
                  );
                  await SheetsApi.updateUser(
                    '1',
                    updatedUser.toJson(),
                  );
                },
                child: const Text('Update first user'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await SheetsApi.updateCellValue(
                      columnId: 'email',
                      rowId: '1',
                      newCellContent: 'updated@email.pl');
                },
                child: const Text('Update first user email address'),
              ),
              const SizedBox(
                height: 20,
              ),
              if (users.isNotEmpty)
                SizedBox(
                  height: 280,
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            title: Text(users[index].name),
                            subtitle: Text(users[index].email),
                            trailing: IconButton(
                              onPressed: () async {
                                final userHasBeenDeleted =
                                    await SheetsApi.deleteRowById(
                                        users[index].id);
                                if (userHasBeenDeleted) {
                                  final res = await SheetsApi.getAllUsers();
                                  setState(() {
                                    users = res;
                                  });
                                }
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          );
                        }),
                  ),
                )
            ],
          ),
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
