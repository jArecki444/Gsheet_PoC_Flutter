import 'package:flutter/material.dart';

import 'gsheets_api/gsheets_api.dart';

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
                  // TODO: Call Gsheet create row method
                },
                child: Text('Add test user'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // TODO: Call Gsheet create row method
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
