// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/models/weather_models.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  // ignore: constant_identifier_names
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'),
      // Uri.parse(
      //   'https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=46d24e0d6f945cb238b6b1fa5f6ff24e',
      // ),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('We are fucked Up!');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.checkPermission();
    }
    // FEATCH THE CURRENT LOCATION
    Position position = await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    String? city = placemarks[0].locality;
    print('${position.latitude} and ${position.longitude}');
    return city ?? "No data";
  }
}
