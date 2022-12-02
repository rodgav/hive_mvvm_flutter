import 'package:hive/hive.dart';

part 'hive_test.g.dart';

@HiveType(typeId: 0)
class PeopleHive extends HiveObject {
  @HiveField(0)
  String? uuid;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? old;

  PeopleHive(this.uuid, this.name, this.old);
}
