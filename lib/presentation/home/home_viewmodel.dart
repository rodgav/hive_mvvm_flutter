import 'package:flutter/foundation.dart';
import 'package:hive_test/domain/model/people.dart';
import 'package:hive_test/domain/usecase/home_usecase.dart';
import 'package:hive_test/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  final _peoplesStreCtrl = BehaviorSubject<List<People>>();
  final _uuidEnabledStreCtrl = BehaviorSubject<bool>();

  @override
  void start() {}

  @override
  void ending() {
    _peoplesStreCtrl.close();
    _uuidEnabledStreCtrl.close();
  }

  @override
  Sink get peoplesInput => _peoplesStreCtrl.sink;

  @override
  Sink get uuidEnabledInput => _uuidEnabledStreCtrl.sink;

  @override
  Stream<List<People>> get peoplesOutput =>
      _peoplesStreCtrl.stream.map((peoples) => peoples);

  @override
  Stream<bool> get uuidEnabledOutput =>
      _uuidEnabledStreCtrl.stream.map((enabled) => enabled);

  @override
  showId(Function(String uuid) setUuidText) {
    final uuid = const Uuid().v1();
    setUuidText.call(uuid);
  }

  @override
  fetchPeople() async {
    (_homeUseCase.fetchPeoples(null))
        .fold((l) => debugPrint(l.error), (r) => peoplesInput.add(r));
  }

  @override
  putPeople(String uuid, String name, String old,
      Function(String uuid) setUuidText) async {
    (await _homeUseCase.execute(People(uuid, name, old)))
        .fold((l) => debugPrint(l.error), (r) {
      showId(setUuidText);
      fetchPeople();
    });
  }

  @override
  enabledUuid(bool bool) {
    uuidEnabledInput.add(bool);
  }
}

abstract class HomeViewModelInput {
  Sink get peoplesInput;

  Sink get uuidEnabledInput;

  showId(Function(String uuid) setUuidText);

  fetchPeople();

  putPeople(
      String uuid, String name, String old, Function(String uuid) setUuidText);

  enabledUuid(bool bool);
}

abstract class HomeViewModelOutput {
  Stream<List<People>> get peoplesOutput;

  Stream<bool> get uuidEnabledOutput;
}
