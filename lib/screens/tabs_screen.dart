import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/data/dummy_data.dart';

import '../models/meal.dart';
import '../widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// As we are showing Favorite Meals here, we can create Favorite Meals List here

class TabsScreen extends StatefulWidget {
  TabsScreen({Key? key}) : super(key: key) {
    print('tabs screen cons');
  }

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // We can use this function by tapping the star icon on MealDetailsScreen(), how to pass there?
  // First, we can pass down it do MealsScreen() here, then to MealDetailsScreen()
  void _toggleFavorite(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal); // returns Boolean
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage(
            'Removed from Favorites'); // can be used also without setState
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage(
            'Added to Favorites'); // can be used also without setState
      });
    }
  }

  //  **** UI Update Trigger  ****
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context)
        .pop(); // closing the drawer first, hence when popped we should back to the categories screen not to drawer
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );

      setState(() {
        _selectedFilters =
            result ?? kInitialFilters; //in case of result is null
      });
      // print(result); //testing
      // {Filter.glutenFree: false, Filter.lactoseFree: true, Filter.vegetarian: true, Filter.vegan: false}
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false; // exclude non gluten-free meals
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false; // exclude non lactose-free meals
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false; // exclude non vegetarian meals
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false; // exclude non vegan meals
      }
      return true; // based on filters
    }).toList();

    Widget activePage = CategoriesScreen(
      toggleFavorite: _toggleFavorite,
      availableMeals: availableMeals,
    ); // index = 0
    String activePageTitle = 'Categories';

    if (_selectedIndex == 1) {
      activePageTitle = 'Favorites';
      activePage = MealsScreen(
        meals: _favoriteMeals,
        toggleFavorite: _toggleFavorite,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFDFC2F5),
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
