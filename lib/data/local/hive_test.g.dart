// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_test.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeopleHiveAdapter extends TypeAdapter<PeopleHive> {
  @override
  final int typeId = 0;

  @override
  PeopleHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeopleHive(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PeopleHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.old);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeopleHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
