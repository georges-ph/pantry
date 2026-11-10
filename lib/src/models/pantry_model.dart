import 'dart:convert';

class PantryModel {
  final String? name;
  final String? description;
  final List<dynamic>? errors;
  final bool? notifications;
  final int? percentFull;
  final List<dynamic>? baskets;

  PantryModel({
    this.name,
    this.description,
    this.errors,
    this.notifications,
    this.percentFull,
    this.baskets,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'errors': errors,
      'notifications': notifications,
      'percentFull': percentFull,
      'baskets': baskets,
    };
  }

  factory PantryModel.fromMap(Map<String, dynamic> map) {
    return PantryModel(
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      errors: map['errors'] != null ? List.from(map['errors']) : null,
      notifications:
          map['notifications'] != null ? map['notifications'] as bool : null,
      percentFull:
          map['percentFull'] != null ? map['percentFull'] as int : null,
      baskets: map['baskets'] != null ? List.from(map['baskets']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PantryModel.fromJson(String source) =>
      PantryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PantryModel(name: $name, description: $description, errors: $errors, notifications: $notifications, percentFull: $percentFull, baskets: $baskets)';
  }
}
