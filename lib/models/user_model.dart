class User {
  final int? id;
  final String name;
  final int age;

  User({
    this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, age: $age}';
  }
}
