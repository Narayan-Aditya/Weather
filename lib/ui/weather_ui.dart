// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/weather_models.dart';
import 'package:weather/service/weather_service.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/theme/theme_provider.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  // API KEY
  final _weatherServices = WeatherService('46d24e0d6f945cb238b6b1fa5f6ff24e');
  Weather? _weather;

  // FETCH WEATHER DATA
  _featchWeather() async {
    String cityName = await _weatherServices.getCurrentCity();
    try {
      final weather = await _weatherServices.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _featchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return (_featchWeather() == null)
        ? CupertinoActivityIndicator()
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                Provider.of<ThemeProvider>(
                  context,
                  listen: false,
                ).toggleTheme();
              },
              child:
                  (Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).isDarkMode)
                  ? Icon(Icons.light_mode, size: 30)
                  : Icon(Icons.dark_mode, size: 30),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 110),
                  Text(
                    _weather?.cityName ?? 'City 🤔',
                    style: TextStyle(fontSize: 50),
                  ),
                  SizedBox(height: 110),
                  (_weather!.temperature.round() <= 20)
                      ? Lottie.asset('assets/sun.json')
                      : Lottie.asset('assets/cloud.json'),
                  SizedBox(height: 110),

                  Text(
                    '${_weather?.temperature.round()} °C',
                    style: TextStyle(fontSize: 50),
                  ),
                ],
              ),
            ),
          );
  }
}
