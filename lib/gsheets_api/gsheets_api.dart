import 'package:gsheets/gsheets.dart';

import 'gsheets_credentials.dart';
// gsheets_credentials.dart is added to gitignore due security reasons
// you need to create your own credentials file
// this file needs to contain json token as sheetCredentials and spreadsheetId

class SheetsApi {
  static Worksheet? _usersTab;
  static Future init() async {
    final gsheetsInstance = GSheets(sheetsCredentials);

    final spreadSheet = await gsheetsInstance.spreadsheet(spreadsheetId);

    _usersTab = spreadSheet.worksheetByTitle('Users');
  }
}
