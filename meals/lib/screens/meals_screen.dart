import 'package:flutter/material.dart';
import 'package:meals/dummyvalues.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_view.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-screen';
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);
//  final String mealsId;
//  final String categoryTitle;
//
//  CategoryMealsScreen(this.mealsId, this.categoryTitle);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen>{
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData =false;

  @override
  void initState() {
     // ...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_loadedInitData) {
      final routeArgs = ModalRoute
          .of(context)
          .settings
          .arguments
      as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId){
     setState(() {
       displayedMeals.removeWhere((meal) => meal.id == mealId);
     });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
       body: ListView.builder(
           itemCount: displayedMeals.length,
           itemBuilder: (ctx, index) {
              var meal = displayedMeals[index];
              return MealItem(
                  id: meal.id,
                  title: meal.title,
                  imageUrl: meal.imageUrl,
                  duration: meal.duration,
                  complexity: meal.complexity,
                  affordability: meal.affordability,
              );
           }
       ),
    );
  }
}
