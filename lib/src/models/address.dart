import 'dart:convert';

import 'city.dart';
import 'phone.dart';

class Address {
  final String street;
  final int number;
  final String zipCode;
  final City city;
  final Phone phone;
  Address({
    required this.street,
    required this.number,
    required this.zipCode,
    required this.city,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'number': number,
      'zipCode': zipCode,
      'city': city.toMap(),
      'phone': phone.toMap(),
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] ?? '',
      number: map['number']?.toInt() ?? 0,
      zipCode: map['zipCode'] ?? '',
      city: City.fromMap(map['city'] ?? {}),
      phone: Phone.fromMap(map['phone'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(street: $street, number: $number, zipCode: $zipCode, city: $city, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.street == street &&
        other.number == number &&
        other.zipCode == zipCode &&
        other.city == city &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return street.hashCode ^
        number.hashCode ^
        zipCode.hashCode ^
        city.hashCode ^
        phone.hashCode;
  }
}
