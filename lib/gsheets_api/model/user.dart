class UserFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  static const String avatarUrl = 'avatarUrl';
}

class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.avatarUrl: avatarUrl,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        id: json[UserFields.id],
        name: json[UserFields.name],
        email: json[UserFields.email],
        avatarUrl: json[UserFields.avatarUrl],
      );
}
