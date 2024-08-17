import 'package:hive/hive.dart';
import 'package:jc_split_bill_flutter/Models/money_record.dart'; // Make sure to import your MoneyRecord class

class HiveCrud {
  static final oweMoneyRecord = Hive.box('split_bill_hive_database');

  static Future<void> addMoneyRecord(Map<String, dynamic> record) async {
    try {
      await oweMoneyRecord.add(record);
      print("Amount of data is ${oweMoneyRecord.length}");
    } catch (e) {
      print("Error $e");
    }
  }

  static Future<void> deleteMoneyRecord(int index) async {
    try {
      final key = oweMoneyRecord.keyAt(index);
      await oweMoneyRecord.delete(key);
      print("Deleted record at index $index");
    } catch (e) {
      print("Error $e");
    }
  }
}
