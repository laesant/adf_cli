import 'package:dio/dio.dart';

import '../models/course.dart';

class ProductDioRepository {
  Future<Course> findByName(String name) async {
    try {
      final response = await Dio().get('http://localhost:8080/products',
          queryParameters: {'name': name});
      final data = response.data;
      if (data.isEmpty) {
        throw Exception('Produto não encontrado');
      }
      return Course.fromMap(data.first);
    } on DioException {
      throw Exception();
    }
  }
}
