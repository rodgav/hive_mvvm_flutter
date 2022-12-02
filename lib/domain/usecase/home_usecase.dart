import 'package:dartz/dartz.dart';
import 'package:hive_test/domain/model/failure.dart';
import 'package:hive_test/domain/model/people.dart';
import 'package:hive_test/domain/repository/repository.dart';
import 'package:hive_test/domain/usecase/base_usecase.dart';

class HomeUseCase
    implements BaseUseCase<People, void>, HomeUseCasePut<void, List<People>> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(People input) =>
      _repository.putPeople(input);

  @override
  Either<Failure, List<People>> fetchPeoples(void input) =>
      _repository.fetchPeoples();
}

abstract class HomeUseCasePut<In, Out> {
  Either<Failure, Out> fetchPeoples(In input);
}
