import 'package:dartz/dartz.dart';
import 'package:hive_test/domain/model/failure.dart';
import 'package:hive_test/domain/model/people.dart';
import 'package:hive_test/domain/repository/repository.dart';
import 'package:hive_test/domain/usecase/base_usecase.dart';

class HomeUseCase
    implements
        BaseUseCase<void, List<People>>,
        HomeUseCasePut<People, void> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, List<People>>> execute(void input) =>
      _repository.fetchPeoples();

  @override
  Future<Either<Failure, void>> putPeople(People input) =>
      _repository.putPeople(input);
}

abstract class HomeUseCasePut<In, Out> {
  Future<Either<Failure, Out>> putPeople(In input);
}
