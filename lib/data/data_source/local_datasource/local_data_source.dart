import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/app/constants.dart';
import 'package:hive_test/data/local/hive_test.dart';
import 'package:hive_test/domain/model/people.dart';

abstract class LocalDataSource {
  List<PeopleHive?> fetchPeoples();

  PeopleHive? fetchPeople(String key);

  Future<void> deletePeoples();

  Future<void> deletePeople(String key);

  Future<void> putPeople(People people);
}

class LocalDataSourceImpl implements LocalDataSource {
  late Box<PeopleHive> _peopleBox;

  LocalDataSourceImpl() {
    _initBoxs();
  }

  _initBoxs() async {
    _peopleBox = await Hive.openBox<PeopleHive>(Constants.peopleBox);
  }

  @override
  List<PeopleHive?> fetchPeoples() {
    //final keys = await _peopleBox.getAllKeys();
    //return _peopleBox.getAll(keys);
    return _peopleBox.values.toList();
  }

  @override
  PeopleHive? fetchPeople(String key) => _peopleBox.get(key);

  @override
  Future<void> deletePeoples() async {
    final keys = _peopleBox.keys;
    return _peopleBox.deleteAll(keys);
  }

  @override
  Future<void> deletePeople(String key) => _peopleBox.delete(key);

  @override
  Future<void> putPeople(People people) => _peopleBox.put(
      people.uuid, PeopleHive(people.uuid, people.name, people.old));
}
