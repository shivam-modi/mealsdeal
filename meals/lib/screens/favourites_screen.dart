import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_view.dart';

class FavouritesScreen extends StatelessWidget {
  final favourites;
  FavouritesScreen(this.favourites);

  @override
  Widget build(BuildContext context) {
    if(favourites.isEmpty){
      return Center(
        child: Text('No favourites yet, Add some!'),
      );
    } else {
       return ListView.builder(
           itemCount: favourites.length,
           itemBuilder: (ctx, index) {
             var meal = favourites[index];
             return MealItem(
               id: meal.id,
               title: meal.title,
               imageUrl: meal.imageUrl,
               duration: meal.duration,
               complexity: meal.complexity,
               affordability: meal.affordability,
             );
           }
       );
    }
  }
}
