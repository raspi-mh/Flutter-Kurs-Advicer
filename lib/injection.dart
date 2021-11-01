import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'application/bloc/advicer_bloc.dart';
import 'domain/repositories/advicer_repository.dart';
import 'domain/usecases/advicer_usecases.dart';
import 'infrastructure/datasources/advicer_remote_datasource.dart';
import 'infrastructure/repositories/advicer_repository_impl.dart';

final sl = GetIt.I; // sl == service locater

Future<void> init() async {
//! Blocs
  sl.registerFactory(() => AdvicerBloc(usecases: sl()));

  //! Usecases
  sl.registerLazySingleton(() => AdvicerUsecases(advicerRepository: sl()));

  //! repos
  sl.registerLazySingleton<AdvicerRepository>(
      () => AdvicerRepositoryImpl(advicerRemoteDatasource: sl()));

  //! datasources
  sl.registerLazySingleton<AdvicerRemoteDatasource>(
      () => AdvicerRemoteDatasourceImpl(client: sl()));

  //! extern
  sl.registerLazySingleton(() => http.Client());
}
