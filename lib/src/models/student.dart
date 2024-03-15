import 'dart:convert';

import 'address.dart';
import 'course.dart';

class Student {
  int ind;
  String name;
  int age;
  List<String> nameCourses;
  List<Course> courses;
  Address address;
  
  Student({
    required this.ind,
    required this.name,
    required this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'ind': ind,
      'name': name,
      'age': age,
      'nameCourses': nameCourses,
      'courses': courses.map((x) => x.toMap()).toList(),
      'address': address.toMap(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      ind: map['ind']?.toInt() ?? 0,
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      nameCourses: List<String>.from(map['nameCourses'] ?? const []),
      courses: List<Course>.from(
          map['courses']?.map((x) => Course.fromMap(x)) ?? const []),
      address: Address.fromMap(map['address']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(ind: $ind, name: $name, age: $age, nameCourses: $nameCourses, courses: $courses, address: $address)';
  }
}
