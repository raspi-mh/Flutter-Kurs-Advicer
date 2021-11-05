import 'package:advicer/application/bloc/advicer_bloc.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'advice_bloc_test.mocks.dart';

@GenerateMocks([AdvicerUsecases])
void main() {
  late AdvicerBloc advicerBloc;
  late MockAdvicerUsecases mockAdvicerUsecases;

  setUp(() {
    mockAdvicerUsecases = MockAdvicerUsecases();
    advicerBloc = AdvicerBloc(usecases: mockAdvicerUsecases);
  });

  test("initState should be AdvicerInitial", () {
// assert
    expect(advicerBloc.state, equals(AdvicerInitial()));
  });

  group("AdviceRequestEvent", () {
    
  });
}
