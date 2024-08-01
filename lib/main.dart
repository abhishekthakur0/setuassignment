import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setuassignment/modules/homepage/view/homepage.dart';
import 'package:setuassignment/utils/extension.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: const String.fromEnvironment('brand_name'),
      theme: ThemeData(
        fontFamily: const String.fromEnvironment('font'),
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: HexColor.fromHex(
          const String.fromEnvironment('primary_color'),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: HexColor.fromHex(
            const String.fromEnvironment('primary_color'),
          ),
        ).copyWith(
          primary: HexColor.fromHex(
            const String.fromEnvironment('primary_color'),
          ),
          secondary: HexColor.fromHex(
            const String.fromEnvironment('secondary_color'),
          ),
        ),
        useMaterial3: false,
      ),
      home: const Homepage(),
    );
  }
}
