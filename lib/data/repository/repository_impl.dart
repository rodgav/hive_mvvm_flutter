import 'package:dartz/dartz.dart';
import 'package:hive_test/data/data_source/local_datasource/local_data_source.dart';
import 'package:hive_test/data/mapper/people_hive_mapper.dart';
import 'package:hive_test/domain/model/failure.dart';
import 'package:hive_test/domain/model/people.dart';
import 'package:hive_test/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final LocalDataSource _localDataSource;

  RepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<People>>> fetchPeoples() async {
    try {
      final peoples = await _localDataSource.fetchPeoples();
      return Right(peoples.map((e) => e.toDomain()).toList());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, People>> fetchPeople(String key) async {
    try {
      final people = await _localDataSource.fetchPeople(key);
      return Right(people.toDomain());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePeoples() async {
    try {
      return Right(await _localDataSource.deletePeoples());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePeople(String key) async {
    try {
      return Right(await _localDataSource.deletePeople(key));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> putPeople(People people) async {

      return Right(await _localDataSource.putPeople(people));

  }
}
