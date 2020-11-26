import 'package:flutter/material.dart';
import 'package:meals/dummyvalues.dart';

class MealDetails extends StatelessWidget {
  static const mealRoute = '/meal-details';
  final Function toggleFavourite;
  final Function isFavourite;

  MealDetails(this.toggleFavourite, this.isFavourite);

  Widget titleBuild(BuildContext context, String title){
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(title,
            style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
     return Container(
         decoration: BoxDecoration(
         color: Colors.white,
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(10)
       ),
         margin: EdgeInsets.all(10),
         padding: EdgeInsets.all(10),
         height: 200,
         width: 300,
         child: child
     );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final chosenMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${chosenMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                  chosenMeal.imageUrl,
                  fit: BoxFit.cover,
              ),
            ),
            titleBuild(context, 'Ingredients'),
             buildContainer(
             ListView.builder(
                 itemCount: chosenMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10,
                    ),
                    child: Text(chosenMeal.ingredients[index]),
                  ),
                ),
              ),
            ),
            titleBuild(context, 'Steps'),
            buildContainer(ListView.builder(
                itemCount: chosenMeal.steps.length,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                    leading: CircleAvatar(child: Text('# ${(index +1)}'),
                    ),
                    title: Text(chosenMeal.steps[index]),
                  ),
                   Divider(),
                ]
              ),
            )),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => toggleFavourite(mealId),
          child: Icon(
            isFavourite(mealId) ? Icons.star: Icons.star_border
          ),
       ),
    );
  }
}
