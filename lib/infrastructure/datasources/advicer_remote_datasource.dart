import 'dart:convert';

import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/infrastructure/exceptions/exceptions.dart';
import 'package:advicer/infrastructure/models/advice_model.dart';
import 'package:http/http.dart' as http;

abstract class AdvicerRemoteDatasource {
  /// request a random advice from free api
  /// throws a server-Exception if respond code is not 200
  Future<AdviceEntity> getRandomAdviceFromApi();
}

class AdvicerRemoteDatasourceImpl implements AdvicerRemoteDatasource {
  final http.Client client = http.Client();
  
  //AdvicerRemoteDatasourceImpl({required this.client});

  @override
  Future<AdviceEntity> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse("https://api.adviceslip.com/advice"),
      headers: {
        'Content-Typ': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);

      return AdviceModel.fromJson(responseBody["slip"]);
    }
  }
}
