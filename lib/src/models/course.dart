import 'dart:convert';

class Course {
  int id;
  String name;
  bool isStudent;
  Course({
    required this.id,
    required this.name,
    required this.isStudent,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isStudent': isStudent,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      isStudent: map['isStudent'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() => 'Course(id: $id, name: $name, isStudent: $isStudent)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.id == id &&
        other.name == name &&
        other.isStudent == isStudent;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isStudent.hashCode;
}
