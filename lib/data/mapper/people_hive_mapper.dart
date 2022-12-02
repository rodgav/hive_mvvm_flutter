import 'package:hive_test/app/extensions.dart';
import 'package:hive_test/data/local/hive_test.dart';
import 'package:hive_test/domain/model/people.dart';

extension PeopleHiveMapper on PeopleHive? {
  People toDomain() {
    return People(this?.uuid?.orEmpty() ?? '', this?.name?.orEmpty() ?? '',
        this?.old?.orEmpty() ?? '');
  }
}
