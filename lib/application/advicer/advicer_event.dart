part of 'advicer_bloc.dart';

@immutable
abstract class AdvicerEvent {}


/// event when button ist pressed
class AdvicerRequestedEvent extends AdvicerEvent {}

class ExampleEvent extends AdvicerEvent {}