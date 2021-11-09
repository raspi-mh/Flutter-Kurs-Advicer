import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/repositories/theme_repository.dart';
import 'package:advicer/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advicer/infrastructure/exceptions/exceptions.dart';
import 'package:advicer/infrastructure/repositories/theme_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_repository_test.mocks.dart';

@GenerateMocks([ThemeLocalDatasource])
void main() {
  late MockThemeLocalDatasource mockThemeLocalDatasource;
  late ThemeRepository themeRepository;

  setUp(() {
    mockThemeLocalDatasource = MockThemeLocalDatasource();
    themeRepository =
        ThemeRepositoryImpl(themeLocalDatasource: mockThemeLocalDatasource);
  });

  group("getThemeMode", () {
    final t_themeMode = true;

    test("should return theme mode if cached data is present", () async {
      // arrange
      when(mockThemeLocalDatasource.getCachedThemeData())
          .thenAnswer((_) async => t_themeMode);
      // act
      final result = await themeRepository.getThemeMode();
      // assert
      expect(result, Right(t_themeMode));
      verify(mockThemeLocalDatasource.getCachedThemeData());
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });

    test("should return CacheFailure if local dadasource throws a cache exception ", () async {
      // arrange
      when(mockThemeLocalDatasource.getCachedThemeData())
          .thenThrow(CacheExeption());
      // act
      final result = await themeRepository.getThemeMode();
      // assert
      expect(result, Left(CacheFailure()));
      verify(mockThemeLocalDatasource.getCachedThemeData());
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });
  });

  group("setThemeMode", () {
    final t_themeMode = true;

    test("should call function to cache theme mode in local datasource", () {
      // arrange
      when(mockThemeLocalDatasource.cacheTeamData(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);
      // act
      themeRepository.setThemeMode(mode: t_themeMode);

      // assert
      verify(mockThemeLocalDatasource.cacheTeamData(mode: t_themeMode));
    });
  });
}
