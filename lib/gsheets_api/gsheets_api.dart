import 'package:gsheets/gsheets.dart';
import 'model/user.dart';

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

  static Future addUser(List<Map<String, dynamic>> rowList) async {
    if (_usersTab == null) return;
    _usersTab!.values.map.appendRows(rowList);
  }

  /// This method is used as helper to set id of new user
  static Future<int> getRowCount() async {
    if (_usersTab == null) return 0;

    final lastRow = await _usersTab!.values.lastRow();
    if (lastRow == null) return 0;

    return int.tryParse(lastRow.first) ?? 0;
  }

  static Future<User?> getUserById(String id) async {
    if (_usersTab == null) return null;

    final jsonResponse = await _usersTab!.values.map.rowByKey(
      id,
      fromColumn: 1,
    );

    return jsonResponse != null ? User.fromJson(jsonResponse) : null;
  }
}
