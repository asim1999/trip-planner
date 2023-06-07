import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/provider/trip_provider.dart';
import 'package:trip_planner/screens/home.dart';

import 'constants.dart';

void main() {
  runApp(
    //Can have multiple providers, good way to structure code even with single one
    MultiProvider(
      providers: [
        //Initialize trip provider on app start
        ChangeNotifierProvider<TripProvider>(
          create: (context) => TripProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.black38,
          centerTitle: true,
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 4),
        ),
        //Form fields
        inputDecorationTheme: InputDecorationTheme(
            fillColor: kFormFieldFill,
            filled: true,
            labelStyle: const TextStyle(color: Color(0xff949494)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            )),
        //Elevated Buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
