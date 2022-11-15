// import libraries
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:switcher_button/switcher_button.dart';

// for making http requests
import 'package:http/http.dart' as http;

void main() {
  return runApp(MainPage());
}

void getDashboard() async {
  // var response = await http.get(
  //   Uri.parse(
  //       'https://api2.arduino.cc/iot/v2/dashboards/2deabc26-4232-4a45-9ba7-ce05bea1f9a3'),
  //   headers: {
  //     'Authorization': 'Bearer <--your-token-here-->',
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json'
  //   },
  // );

  var url = Uri.https('https://api2.arduino.cc/iot/v2/devices/');
  var response = await http.get(url, headers: {
    // 'Authorization': 'Bearer <--your-token-here-->',
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  });
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  print(await http.read(Uri.https('https://api2.arduino.cc/iot/v2/devices/')));
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
    getDashboard();
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
                              NeedlePointer(value: 90)
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  widget: Container(
                                      child: Text('90.0',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold))),
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
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  )),
                )),
            Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 190.0,
                  height: 190.0,
                ))
          ])
        ])),
      ),
    );
  }
}
