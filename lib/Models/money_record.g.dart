// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:hive/hive.dart';
import 'money_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************


class MoneyRecordAdapter extends TypeAdapter<MoneyRecord> {
  @override
  final int typeId = 1;

  @override
  MoneyRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoneyRecord(
      name: fields[0] as String,
      recordedDate: fields[1] as String,
      amount: fields[2] as String,
      remarks: fields[3] as String,
      returned: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MoneyRecord obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.recordedDate)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.remarks)
      ..writeByte(4)
      ..write(obj.returned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
