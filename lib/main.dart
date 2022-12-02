// import libraries
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:led_bulb_indicator/led_bulb_indicator.dart';

// for making http requests
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

String accessToken = '';

void main() {
  return runApp(MainPage());
}

// function to get access token using aayush's client id and credentials
Future<http.Response?> getToken() async {
  var url = Uri.parse('https://api2.arduino.cc/iot/v1/clients/token');
  var response = await http.post(
    url,
    headers: {'content-type': 'application/x-www-form-urlencoded'},
    body: {
      'grant_type': 'client_credentials',
      'client_id': 'rx0ph5orF5cdSfxKuAofB6fJtQAG1j9x', // aayush's client id
      'client_secret':
          'it8b8tyEVU3ANB3xq4nFrO2Py6uQSDSVJfRgR5Sj3LDRxZrf0Mwbu6xM3cy4pa46', // aayush's client credentials
      'audience': 'https://api2.arduino.cc/iot'
    },
  ).then(
    (response) {
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        accessToken = responseData['access_token'];
        return accessToken;
      } else {
        print('Error');
      }
    },
  );
}

// function to print contents of aayush dashboard in JSON format
Future<http.Response?> getDashboard() async {
  var url = Uri.parse(
      'https://api2.arduino.cc/iot/v2/dashboards/2deabc26-4232-4a45-9ba7-ce05bea1f9a3');
  var response = await http.get(
    url,
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    },
  ).then(
    (response) {
      if (response.statusCode == 200) {
        print('Response body: ${response.body}'); // print raw response
        var data = json.decode(response.body);
        print(data); // print response after JSON conversion
      } else {
        throw Exception('Failed to load dashboard');
      }
    },
  );
}

// function to publish value to variable
// variable can be found in aayush_thing
Future<http.Response?> publishSwitchProperty(switchValue) async {
  var url = Uri.parse(
      'https://api2.arduino.cc/iot/v2/things/7ea1ea47-9ca5-4805-94eb-8185d489ac1a/properties/9cc7fc96-ced6-4696-88f8-464611f69b5d/publish');
  var response = await http
      .put(
    url,
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    },
    // payload to publish on thing property
    body: jsonEncode({
      "href":
          "/iot/v1/things/7ea1ea47-9ca5-4805-94eb-8185d489ac1a/properties/9cc7fc96-ced6-4696-88f8-464611f69b5d",
      "id": "9cc7fc96-ced6-4696-88f8-464611f69b5d",
      "device_id": "ea726baa-f244-495a-b70d-b779be76268f",
      "value": switchValue, // boolean value based on switch state
      "name": "aayush_led_switch",
      "permission": "READ_WRITE",
      "persist": true,
      "tag": 4,
      "thing_id": "7ea1ea47-9ca5-4805-94eb-8185d489ac1a",
      "thing_name": "aayush_thing",
      "type": "STATUS",
      "update_parameter": 0,
      "update_strategy": "ON_CHANGE",
      "variable_name": "aayush_led_switch"
    }),
  )
      .then(
    (response) {
      if (response.statusCode == 200) {
        print('Updated variable successfully');
      } else {
        throw Exception('Failed to update variable');
      }
    },
  );
}

// function to publish value to variable
// variable can be found in aayush_thing
Future<http.Response?> publishSliderProperty(sliderValue) async {
  var url = Uri.parse(
      'https://api2.arduino.cc/iot/v2/things/7ea1ea47-9ca5-4805-94eb-8185d489ac1a/properties/086f5360-082c-4982-bf97-4ca487857352/publish');
  var response = await http
      .put(
    url,
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    },
    // payload to publish on thing property
    body: jsonEncode({
      "href":
          "/iot/v1/things/7ea1ea47-9ca5-4805-94eb-8185d489ac1a/properties/086f5360-082c-4982-bf97-4ca487857352",
      "id": "9cc7fc96-ced6-4696-88f8-464611f69b5d",
      "device_id": "086f5360-082c-4982-bf97-4ca487857352",
      "value": sliderValue, // boolean value based on switch state
      "name": "aayush_slider",
      "permission": "READ_WRITE",
      "persist": true,
      "tag": 6,
      "thing_id": "7ea1ea47-9ca5-4805-94eb-8185d489ac1a",
      "thing_name": "aayush_thing",
      "type": "INT",
      "update_parameter": 0,
      "update_strategy": "ON_CHANGE",
      "variable_name": "aayush_slider"
    }),
  )
      .then(
    (response) {
      if (response.statusCode == 200) {
        print('Updated variable successfully');
      } else {
        throw Exception('Failed to update variable');
      }
    },
  );
}

class MainPage extends StatefulWidget {
  MyApp createState() => MyApp();
}

class MyApp extends State<MainPage> {
  // SfRangeValues _values = SfRangeValues(0.0, 80.0);
  double _value = 40.0;
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('My Dashboard')),
          body: SafeArea(
            child: Column(children: [
              Row(children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 190.0,
                      height: 190.0,
                      child: Card(
                          child: SfSlider(
                        min: 0.0,
                        max: 100.0,
                        value: _value,
                        interval: 20,
                        showTicks: true,
                        showLabels: true,
                        enableTooltip: true,
                        minorTicksPerInterval: 1,
                        onChanged: (dynamic value) {
                          setState(() {
                            _value = value;
                            getToken(); // get token
                            publishSliderProperty(value);
                          });
                        },
                      )),
                    )),
                Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 190.0,
                      height: 190.0,
                      child: Card(
                          child: SfRadialGauge(
                              enableLoadingAnimation: true,
                              animationDuration: 4500,
                              axes: <RadialAxis>[
                            RadialAxis(
                                minimum: 0,
                                maximum: 150,
                                ranges: <GaugeRange>[
                                  GaugeRange(
                                      startValue: 0,
                                      endValue: 50,
                                      color: Colors.green),
                                  GaugeRange(
                                      startValue: 50,
                                      endValue: 100,
                                      color: Colors.orange),
                                  GaugeRange(
                                      startValue: 100,
                                      endValue: 150,
                                      color: Colors.red)
                                ],
                                pointers: <GaugePointer>[
                                  NeedlePointer(value: _value)
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                      widget: Container(
                                          child: Text('$_value',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      angle: 90,
                                      positionFactor: 0.5)
                                ])
                          ])),
                    ))
              ]),
              Row(children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 190.0,
                      height: 190.0,
                      child: Card(
                          child: Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                            getToken(); // get token
                            //getDashboard(); // get dashboard info
                            publishSwitchProperty(value);
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      )),
                    )),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                      width: 150.0,
                      height: 150.0,
                      child: Card(
                          child: LedBulbIndicator(
                              initialState: LedBulbColors.red,
                              glow: true,
                              size: 50))),
                )
              ]),
            ]),
          )),
    );
  }
}
