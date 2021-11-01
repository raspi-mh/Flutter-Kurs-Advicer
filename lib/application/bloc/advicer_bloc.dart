import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {

  final AdvicerUsecases  usecases;

  AdvicerBloc({required this.usecases}) : super(AdvicerInitial()) {
    on<AdvicerRequestedEvent>((event, emit) async {
      emit(AdvicerStateLoading());
      // do something
      Either<Failure, AdviceEntity> adviceOrFailure =
          await usecases.getAdviceUsecase();

      adviceOrFailure.fold(
          (failure) =>
              emit(AdvicerStateError(message: _mapFailureToMessage(failure))),
          (advice) => emit(AdvicerStateLoaded(advice: advice.advice)));
    });

    on<ExampleEvent>((event, emit) {});
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Ups, API Error, please try again!";
      case GeneralFailure:
        return "Ups, something gone wrong. Please try again";

      default:
        return "Ups, something gone wrong. Try again";
    }
  }
}
