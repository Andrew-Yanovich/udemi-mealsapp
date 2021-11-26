import 'package:flutter/material.dart';
import '../dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten']! && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose']! && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegetarian']! && !meal.isVegetarian){
          return false;
        }
        if(_filters['vegan']! && !meal.isVegan){
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(secondary: Colors.amber),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontFamily: 'Raleway',
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 21, 21, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 21, 21, 1),
              ),
              subtitle1: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
      ),
      //home: const CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealsScreen.routName: (ctx) => CategoryMealsScreen(availableMeals: _availableMeals,),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(currentFilters: _filters, saveFilters: _setFilters,),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
