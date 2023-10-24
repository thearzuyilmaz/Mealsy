import 'package:flutter/material.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  // added WidgetRef ref as it is stateLESS
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: const EdgeInsets.only(left: 16, right: 16),
            secondary: const Icon(
              Icons.bakery_dining_sharp,
              size: 36,
            ),
            title: Text(
              'Gluten-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (bool newValue) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, newValue);
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: const EdgeInsets.only(left: 16, right: 16),
            secondary: const Icon(
              Icons.local_drink,
              size: 36,
            ),
            title: Text(
              'Lactose-free',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (bool newValue) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, newValue);
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: const EdgeInsets.only(left: 16, right: 16),
            secondary: const Icon(
              Icons.emoji_nature,
              size: 36,
            ),
            title: Text(
              'Vegetarian',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (bool newValue) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, newValue);
            },
          ),
          SwitchListTile(
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: const EdgeInsets.only(left: 16, right: 16),
            secondary: const Icon(
              Icons.pets,
              size: 36,
            ),
            title: Text(
              'Vegan',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
            value: activeFilters[Filter.vegan]!,
            onChanged: (bool newValue) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, newValue);
            },
          )
        ],
      ),
    );
  }
}

// We can also add a drawer here

// drawer: MainDrawer(
//   onSelectScreen: (String identifier) {
//     Navigator.of(context)
//         .pop(); // going back to FiltersScreen() if Filters is clicked on Drawer
//     if (identifier == 'meals') {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => const TabsScreen(),
//         ),
//       );
//     }
//   },
// ),
