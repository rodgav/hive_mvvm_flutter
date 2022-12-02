import 'package:dartz/dartz.dart';
import 'package:hive_test/domain/model/failure.dart';
import 'package:hive_test/domain/model/people.dart';

abstract class Repository {
  Future<Either<Failure, List<People>>> fetchPeoples();

  Future<Either<Failure, People>> fetchPeople(String key);

  Future<Either<Failure, void>> deletePeoples();

  Future<Either<Failure, void>> deletePeople(String key);

  Future<Either<Failure, void>> putPeople(People people);
}
