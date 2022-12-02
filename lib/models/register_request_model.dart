class RegisterRequestModel {
  RegisterRequestModel({
    required this.username,
    required this.email,
    required this.password,
    required this.roles,
  });
  late final String username;
  late final String email;
  late final String password;
  late final List<String> roles;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    roles = List.castFrom<dynamic, String>(json['roles']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['email'] = email;
    _data['password'] = password;
    _data['roles'] = roles;
    return _data;
  }

  Object? toJSON() {}
}
