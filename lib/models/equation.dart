import 'dart:convert';

class Equation {
  final String equation;
  final DateTime createdAt;
  Equation({
    required this.equation,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'equation': equation,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Equation.fromMap(Map<String, dynamic> map) {
    return Equation(
      equation: map['equation'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Equation.fromJson(String source) => Equation.fromMap(json.decode(source) as Map<String, dynamic>);
}
