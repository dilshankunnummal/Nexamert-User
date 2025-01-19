import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  String address;
  final List<String> pincode;
  final String type;
  final String token;
  final List<dynamic> cart;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.pincode,
      required this.address,
      required this.type,
      required this.token,
      required this.cart});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'pincode': pincode,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      address: map['address'] as String,
      pincode: List<String>.from(map['pincode']),
      type: map['type'] as String,
      token: map['token'] as String,
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    List<String>? pincode,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      pincode: pincode ?? this.pincode,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}
