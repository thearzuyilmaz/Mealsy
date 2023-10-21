import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.toggleFavorite});

  final String? title; //nullable hence optional, no required keyword
  final List<Meal> meals; //meals comes filtered based on category here
  final void Function(Meal meal)
      toggleFavorite; // optional, we will pass this to MealDetailScreen()

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(
          meal: meal,
          toggleFavorite: toggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // *************  if meals is empty, the default empty screen *************
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh nothing here...',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting a different category',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );

    // ************* if meals is NOT empty *************
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
            meal: meals[index],
            onSelectMealCard: (meal) {
              selectMeal(context, meal);
            }),
      );
    }

    // For Favorites Page, we set the title there, not with MealsScreen(),
    if (title == null) {
      return content;
    }

    // For category Meals, we set the title with MealsScreen() parameter
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
