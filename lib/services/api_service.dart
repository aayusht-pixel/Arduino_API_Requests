import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:liquimech_app/models/login_response_model.dart';
import 'package:liquimech_app/services/shared_service.dart';
import '../config.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_mode.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));

      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'content-Type': 'application/json',
      'Charset': 'utf-8'
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    print(response);

    return RegisterResponseModel.fromJson(jsonDecode(response.body));
  }
}
