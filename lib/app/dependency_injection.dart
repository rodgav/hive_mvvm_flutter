import 'package:get_it/get_it.dart';
import 'package:hive_test/data/data_source/local_datasource/local_data_source.dart';
import 'package:hive_test/data/local/hive_local_client_factory.dart';
import 'package:hive_test/data/repository/repository_impl.dart';
import 'package:hive_test/domain/repository/repository.dart';
import 'package:hive_test/domain/usecase/home_usecase.dart';
import 'package:hive_test/presentation/home/home_viewmodel.dart';

final getIt = GetIt.instance;

Future<void> initModule() async {
  getIt.registerLazySingleton<HiveLocalClientFactory>(
      () => HiveLocalClientFactory());
  await getIt<HiveLocalClientFactory>().initHive();
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  getIt.registerLazySingleton<Repository>(() => RepositoryImpl(getIt()));
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    getIt.registerLazySingleton<HomeUseCase>(() => HomeUseCase(getIt()));
    getIt.registerLazySingleton<HomeViewModel>(() => HomeViewModel(getIt()));
  }
}
