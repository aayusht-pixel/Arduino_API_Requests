import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_liquimech_dashboards/constants.dart';
import 'package:my_liquimech_dashboards/my_json_class.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Secure Storage library

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
      (response) async {
        var responseData = json.decode(response.body);
        String accessToken = responseData['access_token'];
        print('ApiService class here!'); // string to show class is working
        //print(accessToken); // print access token
        print(
            'Running Secure Storage here!'); // string to show Secure Storage is working
        var storage = new FlutterSecureStorage(); // create storage
        await storage.write(key: 'jwt', value: accessToken); // write value
        print('Returning token now!'); // string to show token is being returned
        //print(await storage.read(key: 'jwt')); // print stored access token from Secure Storage
        return (await storage.read(key: 'jwt')); // return the access token
      },
    );
  }
}
