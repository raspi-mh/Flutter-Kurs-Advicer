import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/repositories/theme_repository.dart';
import 'package:advicer/infrastructure/datasources/theme_local_datasource.dart';
import 'package:dartz/dartz.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDatasource themeLocalDatasource;

  ThemeRepositoryImpl({required this.themeLocalDatasource});

  @override
  Future<Either<Failure, bool>> getThemeMode() async {
    try {
      final themeMode = await themeLocalDatasource.getCachedThemeData();
      return Right(themeMode);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> setThemeMode({required bool mode}) {
    return themeLocalDatasource.cacheTeamData(mode: mode);
  }
}
