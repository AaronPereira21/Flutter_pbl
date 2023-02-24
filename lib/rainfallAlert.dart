import 'dart:convert';
import 'package:dis_man_sym/alerts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'weatherforecast.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apiKey = '54a4215d65eb60a2a0c49c14c289a227';
  String city = "Mumbai";
  dynamic weatherData;

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  Future<void> getWeatherData() async {
    String url =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    Uri uri = Uri.parse(url);

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: weatherData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Temperature: ${weatherData['main']['temp']}°C',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w300,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'City: ${weatherData['name']}',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Weather: ${weatherData['weather'][0]['description']}',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  weatherData['rain'] == null
                      ? Text(
                          'Rain: Not available',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          'Rain: ${weatherData['rain']['1h']}mm',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}
