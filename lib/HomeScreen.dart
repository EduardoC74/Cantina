import 'dart:convert';
import 'dart:io';
import 'package:cantina_amov_flutter/MealScreen.dart';
import 'package:cantina_amov_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CantinaModel.dart'; // Import the Week class

//const String _menuUrl = 'http://10.0.2.2:8080/menu';
String _menuUrl = 'http://localhost:8080/menu';
//const String _menuUrl = 'http://localhost:8080/menu';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required String title}) : super(key: key);
  static const String routeName = '/HomeScreen';


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Week week = Week.empty();
  bool _fetchingData = false;

  _refresh() {
    _getMenu();
  }
  @override
  void initState() {
    super.initState();
    _getMenu(); // Get the menu when the screen is initialized
  }

  // Method to get the menu information from the server
  Future<void> _getMenu() async {
    try{
      setState(() => _fetchingData = true);
      // Make the HTTP request to the server

      http.Response response = await http.get(Uri.parse(_menuUrl));
      //http.Response response = await http.get(Uri.parse("http://localhost:8080/menu"));
      if (response.statusCode == HttpStatus.ok) {
        debugPrint(response.body);
        // Parse the JSON response
        Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));

        // Create the Week object from the JSON
        setState(() {
          week = Week.fromJson(json);
          week.initializeWeek();
          //_fetchingData = false;
        });

      }
    }catch(ex){
      debugPrint('Something went wrong: $ex');
    } finally {
      setState(() => _fetchingData = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Align(
        alignment: Alignment.centerLeft,
        child: week != null
            ? ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {

            if(week.days.isEmpty)
              return Container();

            Meal meal = week.days[index].getMeal();
            MaterialColor colors = Colors.indigo;


            print(week.days[index].update.hashCode);
            print(week.days[index].update != week.days[index].original);
            print(week.days[index].original.hashCode);
            if(week.days[index].update != null && !week.days[index].getIguais())
              colors = Colors.lightBlue;

            return Card(
              clipBehavior: Clip.antiAlias,
              shadowColor: Colors.amber,
              elevation: 8,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              //margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child:  Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [colors, Colors.black],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                    )
                ),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(meal.weekDay, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    Text("Soup: " + meal.soup, style: TextStyle(fontSize: 13)),
                    Text("Fish: " +meal.fish, style: TextStyle(fontSize: 13)),
                    Text("Meat: " +meal.meat, style: TextStyle(fontSize: 13)),
                    Text("Vegetarian: " +meal.vegetarian, style: TextStyle(fontSize: 13)),
                    Text("Desert: " +meal.desert, style: TextStyle(fontSize: 13)),
                    TextButton(
                        child: Text('Editar'),
                        onPressed: () =>
                            Navigator.pushNamed(context, MealScreen.routeName,
                                arguments: week.days[index])
                    )
                  ],
                ),
              ),
            );
          },
        ) : const Align(
          alignment: Alignment.centerLeft,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              heroTag: "AmovFB2",
              onPressed: _refresh ,
              tooltip: 'Refresh',
              child: const Icon(Icons.refresh),
              backgroundColor: Color.fromRGBO(95, 158, 160, 1),
            ),
          ),
        ],
      ),
    );
  }
}