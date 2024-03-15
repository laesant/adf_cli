import 'dart:convert';

import 'address.dart';
import 'course.dart';

class Student {
  final int? id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<Course> courses;
  final Address address;

  Student({
    this.id,
    required this.name,
    this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'nameCourses': nameCourses,
      'courses': courses.map((course) => course.toMap()).toList(),
      'address': address.toMap(),
    };

    if (age != null) {
      data['age'] = age;
    }

    return data;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      age: map['age']?.toInt(),
      nameCourses: List<String>.from(map['nameCourses'] ?? const []),
      courses: List<Course>.from(
          map['courses']?.map((c) => Course.fromMap(c)) ?? const []),
      address: Address.fromMap(map['address']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(id: $id, name: $name, age: $age, nameCourses: $nameCourses, courses: $courses, address: $address)';
  }
}
