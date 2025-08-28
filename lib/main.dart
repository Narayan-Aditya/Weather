import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/theme/theme_provider.dart';
import 'package:weather/ui/weather_ui.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherHomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
