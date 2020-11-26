import 'package:flutter/material.dart';
import 'package:meals/widgets/category_item.dart';

import 'package:meals/dummyvalues.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GridView(
          padding: const EdgeInsets.all(25),
          children: DUMMY_CATEGORIES.map((mealData) => CategoryItem(mealData.id,
              mealData.title,
              mealData.color)
          ).toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
          ),
    );
  }
}
