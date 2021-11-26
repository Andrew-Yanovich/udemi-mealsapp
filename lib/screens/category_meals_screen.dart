import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routName = '/category-meals';

  final List<Meal> availableMeals;

  const CategoryMealsScreen({Key? key, required this.availableMeals}) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String? categoryTitle;
  List<Meal>? displayedMeals;
  var _loadInitData = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_loadInitData){
      final routArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routArgs['title'];
      final categoryId = routArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
    }
    _loadInitData = true;
    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId){
  //   setState(() {
  //     displayedMeals!.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals![index].id,
            title: displayedMeals![index].title,
            imageUrl: displayedMeals![index].imageUrl,
            duration: displayedMeals![index].duration,
            complexity: displayedMeals![index].complexity,
            affordability: displayedMeals![index].affordability,
          );
        },
        itemCount: displayedMeals!.length,
      ),
    );
  }
}
