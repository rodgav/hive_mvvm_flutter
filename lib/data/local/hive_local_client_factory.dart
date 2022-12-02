import 'package:hive_flutter/adapters.dart';
import 'package:hive_test/data/local/hive_test.dart';

class HiveLocalClientFactory {
  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PeopleHiveAdapter());
  }
}
