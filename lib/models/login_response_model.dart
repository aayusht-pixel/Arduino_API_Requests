import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.id,
    required this.username,
    required this.email,
    required this.roles,
    required this.accessToken,
  });
  late final int id;
  late final String username;
  late final String email;
  late final List<String> roles;
  late final String accessToken;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    roles = List.castFrom<dynamic, String>(json['roles']);
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['email'] = email;
    _data['roles'] = roles;
    _data['accessToken'] = accessToken;
    return _data;
  }
}
