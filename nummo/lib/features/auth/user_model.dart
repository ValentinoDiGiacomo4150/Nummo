import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 3)
class User extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final double balance;

  @HiveField(4)
  final String password;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.balance = 0.0,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    password: json['password'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'balance': balance,
    'password': password,
  };

  User copyWith({String? id, String? email, String? name, double? balance, String? password}) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          name == other.name &&
          balance == other.balance &&
          password == other.password;

  @override
  int get hashCode =>
      id.hashCode ^ email.hashCode ^ name.hashCode ^ balance.hashCode ^ password.hashCode;
}