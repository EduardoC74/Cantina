import 'package:cantina_amov_flutter/CantinaModel.dart';
import 'package:cantina_amov_flutter/MealScreen.dart';
import 'package:flutter/material.dart';
import 'package:cantina_amov_flutter/HomeScreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CantinaApp',
      theme: ThemeData(
        //scaffoldBackgroundColor: Colors.lightBlue[800],
        brightness: Brightness.dark,
        // fontFamily: 'Consolas',
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(title: 'Flutter Demo Home Page'),
        MealScreen.routeName:(context) => MealScreen()
      },
    );
  }
}

