import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

// StateNotifier, returns map
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        }); // initial state is a map of Filters
  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; // not allowed! => mutating state
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setAllFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

// StateNotifierProvider => (calling the related Notifier)
final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

// Combining providers synced, returns list
final filteredMealsProvider = Provider(
  (ref) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);

    return meals.where(
      (meal) {
        if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false; // exclude non gluten-free meals
        }
        if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
          return false; // exclude non lactose-free meals
        }
        if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
          return false; // exclude non vegetarian meals
        }
        if (activeFilters[Filter.vegan]! && !meal.isVegan) {
          return false; // exclude non vegan meals
        }
        return true; // based on filters
      },
    ).toList();
  },
);
