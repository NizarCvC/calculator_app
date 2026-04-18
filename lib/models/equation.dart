import 'dart:convert';

class Equation {
  final String id;
  final String equation;
  final String result;
  final DateTime createdAt;
  const Equation({
    required this.id,
    required this.equation,
    required this.result,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'equation': equation,
      'result': result,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Equation.fromMap(Map<String, dynamic> map) {
    return Equation(
      id: map['id'] as String,
      equation: map['equation'] as String,
      result: map['result'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Equation.fromJson(String source) => Equation.fromMap(json.decode(source) as Map<String, dynamic>);
}
