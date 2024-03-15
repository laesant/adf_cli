import 'dart:convert';

class Phone {
  int ddd;
  String phone;

  Phone({
    required this.ddd,
    required this.phone,
  });

  Map<String, dynamic> toMap() => {'ddd': ddd, 'phone': phone};

  String toJson() => json.encode(toMap());

  factory Phone.fromMap(Map<String, dynamic> data) =>
      Phone(ddd: data['ddd'], phone: data['phone']);

  factory Phone.fromJson(String str) => Phone.fromMap(json.decode(str));
}
