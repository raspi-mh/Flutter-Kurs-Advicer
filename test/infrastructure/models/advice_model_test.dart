import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final t_AdviceModel = AdviceModel(advice: "test", id: 1);

  test("model should be subclass of advice-entity", () {
    // assert
    expect(t_AdviceModel, isA<AdviceEntity>());
  });
}
