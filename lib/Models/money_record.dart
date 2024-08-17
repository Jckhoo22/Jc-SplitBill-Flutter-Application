import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class MoneyRecord {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String recordedDate;

  @HiveField(2)
  final String amount;

  @HiveField(3)
  final String remarks;

  @HiveField(4)
  final bool returned;

  // Constructor
  MoneyRecord({
    required this.name,
    required this.recordedDate,
    required this.amount,
    required this.remarks,
    required this.returned,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'recordedDate': recordedDate,
      'amount': amount,
      'remarks': remarks,
      'returned': returned,
    };
  }
}
