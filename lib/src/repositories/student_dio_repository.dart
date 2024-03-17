import 'package:dio/dio.dart';

import '../models/student.dart';

class StudentDioRepository {
  Future<List<Student>> findAll() async {
    try {
      final response = await Dio().get('http://localhost:8080/students');
      return response.data.map<Student>((e) => Student.fromMap(e)).toList();
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<Student> findById(int id) async {
    try {
      final response = await Dio().get('http://localhost:8080/students/$id');
      if (response.data == null) {
        throw Exception();
      }

      return Student.fromMap(response.data);
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> insert(Student student) async {
    try {
      await Dio().post('http://localhost:8080/students', data: student.toMap());
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> update(Student student) async {
    try {
      await Dio().put('http://localhost:8080/students/${student.id}',
          data: student.toMap());
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    try {
      await Dio().delete('http://localhost:8080/students/$id');
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }
}
