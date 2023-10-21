import 'package:flutter/material.dart';
import 'package:meals_app/screens/main_drawer.dart';
import 'package:meals_app/screens/tabs_screen.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;
  bool _vegan = false;

  // updating the values coming data from the Tabs_Screen
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutenFree = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFree = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarian = widget.currentFilters[Filter.vegetarian]!;
    _vegan = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    Map<Filter, bool> filterValues = {
      Filter.glutenFree: _glutenFree,
      Filter.lactoseFree: _lactoseFree,
      Filter.vegetarian: _vegetarian,
      Filter.vegan: _vegan,
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(filterValues);
          return false; // We already return by navigating manually, hence we do not need to return back again (pop twice)
        },
        child: Column(children: [
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
            value: _glutenFree,
            onChanged: (bool newValue) {
              setState(
                () {
                  _glutenFree = newValue;
                },
              );
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
            value: _lactoseFree,
            onChanged: (bool newValue) {
              setState(
                () {
                  _lactoseFree = newValue;
                },
              );
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
            value: _vegetarian,
            onChanged: (bool newValue) {
              setState(
                () {
                  _vegetarian = newValue;
                },
              );
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
            value: _vegan,
            onChanged: (bool newValue) {
              setState(
                () {
                  _vegan = newValue;
                },
              );
            },
          )
        ]),
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
