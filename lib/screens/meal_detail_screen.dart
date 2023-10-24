import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';

// provider
class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  // putting WidgetRef ref for provider differently than the ConsumerStatefulWidget as there is state there
  // we don't have general ref property in stateless, we have ref as a parameter of build method
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // for Text widget, we should check here
    final isFavorite = ref.watch(favoriteMealsProvider).contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          // for function takes a function like onPressed or something similar, use read not watch
          // I guess watch is something like ongoing listener, that is problematic for onPressed that needs to read a value once
          IconButton(
            onPressed: () {
              // favoriteMealsProvider.notifier: to reach to notifier which has the toggle method
              final isAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              // checking immediately after changing the status

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      isAdded ? 'Meal added as favorite.' : 'Meal removed.'),
                ),
              );
            },
            icon: isFavorite
                ? Icon(Icons.star)
                : Icon(Icons.star_border_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final ingredient in meal.ingredients)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
