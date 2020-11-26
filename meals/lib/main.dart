import 'package:flutter/material.dart';
import 'package:meals/dummyvalues.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/filter_screens.dart';
import 'package:meals/screens/meals_details.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters =  {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
       setState(() {
         _filters = filterData;
         _availableMeals = DUMMY_MEALS.where((meal) {
            if(_filters['gluten'] && !meal.isGlutenFree){
              return false;
            }
            if(_filters['lactose'] && !meal.isLactoseFree){
              return false;
            }
            if(_filters['vegetarian'] && !meal.isVegetarian){
              return false;
            }
            if(_filters['vegan'] && !meal.isVegan){
              return false;
            }
            return true;
         }).toList();
       });
  }

  void _toggleFavourite(String mealId){
    final existingIndex =
         _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0){
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere(
                (meal) => meal.id == mealId
          )
        );
      });
    }
  }

  bool _isMealFavourite(String id) {
     return _favouriteMeals.any((meal) => meal.id == id);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "YummMeals",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.orangeAccent,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1)
          ),
          body2: TextStyle(
              color: Color.fromRGBO( 21, 51, 54, 2)
          ),
          title: TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          )
        )
      ),
                        //      home: CategoriesScreen(),
       initialRoute: '/', // use to set home route other than /
      routes: {
        '/': (ctx) => TabsScreen(_favouriteMeals),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetails.mealRoute: (ctx) => MealDetails(_toggleFavourite, _isMealFavourite),
      },
     // onGenerateRoute: ,
      //onUnknownRoute: ,
    );
  }
}


//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("YummMeals"),
//      ),
//      body: Center(
//        child: Text('Navigation Time!'),
//      ),
//    );
//  }
//}
