import 'dart:convert';

class City {
  int id;
  String name;
  City({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() => {'id': id, 'name': name};

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> data) =>
      City(id: data['id'], name: data['name']);

  factory City.fromJson(String str) => City.fromMap(json.decode(str));
}
