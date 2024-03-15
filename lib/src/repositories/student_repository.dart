import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/student.dart';

class StudentRepository {
  Future<List<Student>> findAll() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/students'));

    if (response.statusCode != 200) {
      throw Exception();
    }

    final data = json.decode(response.body);
    return data.map<Student>((e) => Student.fromMap(e)).toList();
  }

  Future<Student> findById(int id) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/students/$id'));

    if (response.statusCode != 200) {
      throw Exception();
    }

    if (response.body == '{}') {
      throw Exception();
    }

    return Student.fromJson(response.body);
  }

  Future<void> insert(Student student) async {}

  Future<void> update(Student student) async {}

  Future<void> deleteById(int id) async {}
}
