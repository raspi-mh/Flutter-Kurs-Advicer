import 'package:advicer/domain/repositories/theme_repository.dart';
import 'package:advicer/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advicer/infrastructure/repositories/theme_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
  sl.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(themeLocalDatasource: sl()));

  //! datasources
  sl.registerLazySingleton<AdvicerRemoteDatasource>(
      () => AdvicerRemoteDatasourceImpl(client: sl()));
  sl.resetLazySingleton<ThemeLocalDatasource>(
      instance: () => ThemeLocalDatasourceImpl(sharedPreferences: sl()));

  //! extern
  sl.registerLazySingleton(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
