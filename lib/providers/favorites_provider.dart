import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier()
      : super([]); //  sets the initial state as an empty list of meals.

  // add & remove methods are not supported by the riverpod package!!!!!

  void toggleMealFavoriteStatus(Meal meal) {
    // removing meal if it's already in the list
    if (state.contains(meal)) {
      state = state.where((m) => m.id != meal.id).toList();

      // adding meal if it's not in the list
    } else {
      state = [...state, meal];
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
        (ref) => FavoriteMealsNotifier());
