import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:my_liquimech_dashboards/constants.dart';

class ApiService {
  Future<http.Response?> getToken() async {
    var url = Uri.parse(ApiConstants.urlToken);
    var response = await http.post(
      url,
      headers: {'content-type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'client_credentials',
        'client_id': ApiConstants.clientId, // aayush's client id
        'client_secret':
            ApiConstants.clientSecret, // aayush's client credentials
        'audience': ApiConstants.apiAudience
      },
    ).then(
      (response) {
        if (response.statusCode == 200) {
          var responseData = json.decode(response.body);
          String accessToken = responseData['access_token'];
          return accessToken;
        } else {
          print('Error');
        }
      },
    );
  }
}
