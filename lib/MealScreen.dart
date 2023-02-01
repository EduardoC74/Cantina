import 'dart:convert';
import 'dart:io';
import 'package:cantina_amov_flutter/HomeScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'CantinaModel.dart';
import 'package:http/http.dart' as http;

//String url = 'http://10.0.2.2:8080/menu';
String url = 'http://localhost:8080/menu';
class MealScreen extends StatefulWidget {
  const MealScreen({Key? key}): super(key: key);
  static const String routeName = "/MealScreen";


  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  late final Day _day = ModalRoute.of(context)!.settings.arguments as Day;
  final _formKey = GlobalKey<FormState>();

  String? img;
  late String weekDay;
  late String soup;
  late String fish;
  late String meat;
  late String vegetarian;
  late String desert;


  late TextEditingController _imgController;
  late TextEditingController _weekDayController;
  late TextEditingController _soupController;
  late TextEditingController _fishController;
  late TextEditingController _meatController;
  late TextEditingController _vegetarianController;
  late TextEditingController _desertController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _imgController = TextEditingController(text: _day.getMeal().img);
    _weekDayController = TextEditingController(text: _day.getMeal().weekDay);
    _soupController = TextEditingController(text: _day.getMeal().soup);
    _fishController = TextEditingController(text: _day.getMeal().fish);
    _meatController = TextEditingController(text: _day.getMeal().meat);
    _vegetarianController = TextEditingController(text: _day.getMeal().vegetarian);
    _desertController = TextEditingController(text: _day.getMeal().desert);
    // Initialize code that depends on inherited widgets here
  }


  //late final int _counter = ModalRoute.of(context)!.settings.arguments as int;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit meal'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Image URL'),
              controller: _imgController,
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Week day'),
              controller: _weekDayController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Soup'),
              controller: _soupController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Fish'),
              controller: _fishController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Meat'),
              controller: _meatController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Vegetarian'),
              controller: _vegetarianController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Desert'),
              controller: _desertController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      img = _imgController.text;
                      weekDay = _weekDayController.text;
                      soup = _soupController.text;
                      fish = _fishController.text;
                      meat = _meatController.text;
                      vegetarian = _vegetarianController.text;
                      desert = _desertController.text;


                      Map<String, String> headers = {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer YOUR_TOKEN_HERE',
                      };

                      Meal meal = Meal(
                        img,
                        weekDay,
                        soup,
                        fish,
                        meat,
                        vegetarian,
                        desert,
                      );
                      print(meal);

                      String json = jsonEncode(meal);
                      print("json"+json);
                      http.Response response = await http.post(
                        Uri.parse(url),
                        headers: headers,
                        body: json,
                      );

                      // int statusCode = response.statusCode;
                      // String body = response.body;
                      // // Save the edited meal and return to the previous screen
                      // print(body);
                      Navigator.pushNamed(context, HomeScreen.routeName,
                          arguments: meal);
                      //Navigator.pop(context);
                    }
                  },
                  child: Text('Save'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      img = _day.original.img;
                      weekDay = _day.original.weekDay;
                      soup = _day.original.soup;
                      fish = _day.original.fish;
                      meat = _day.original.meat;
                      vegetarian = _day.original.vegetarian;
                      desert = _day.original.desert;

                      Map<String, String> headers = {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer YOUR_TOKEN_HERE',
                      };

                      Meal meal = Meal(
                        null,
                        weekDay,
                        soup,
                        fish,
                        meat,
                        vegetarian,
                        desert,
                      );

                      print(meal);

                      String json = jsonEncode(meal);
                      print("json"+json);
                      http.Response response = await http.post(
                        Uri.parse(url),
                        headers: headers,
                        body: json,
                      );

                      // int statusCode = response.statusCode;
                      // String body = response.body;
                      // // Save the edited meal and return to the previous screen
                      // print(body);
                      Navigator.pushNamed(context, HomeScreen.routeName,
                          arguments: meal);
                      //Navigator.pop(context);
                    }
                  },
                  child: Text('Repor'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>('_weekDayController', _weekDayController));
  }
}
