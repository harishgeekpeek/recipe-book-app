import 'package:flutter/foundation.dart';
import '../models/recipe.dart';

class RecipeProvider extends ChangeNotifier {
  final List<Recipe> _recipes = [
    Recipe(
      id: '1',
      name: 'Paneer Butter Masala',
      emoji: '🍲',
      cookTime: '30 min',
      ingredients: [
        '200g paneer, cubed',
        '2 onions, finely chopped',
        '2 tomatoes, pureed',
        '1 tbsp ginger-garlic paste',
        '2 tbsp butter',
        '1/2 cup cream',
        '1 tsp red chilli powder',
        'Salt to taste',
      ],
      steps: [
        'Heat butter in a pan and sauté onions until golden.',
        'Add ginger-garlic paste and cook for 1 minute.',
        'Add tomato puree, chilli powder and salt; cook until oil separates.',
        'Add a little water, then stir in cream.',
        'Add paneer cubes and simmer for 5 minutes.',
        'Garnish with cream and serve hot with naan or rice.',
      ],
    ),
    Recipe(
      id: '2',
      name: 'Masala Maggi',
      emoji: '🍜',
      cookTime: '10 min',
      ingredients: [
        '1 packet Maggi noodles',
        '1 tsp oil',
        '1/2 onion, chopped',
        '1/2 tomato, chopped',
        'Maggi tastemaker',
        'Pinch of turmeric (optional)',
      ],
      steps: [
        'Boil 1.5 cups of water in a pan.',
        'Add oil, onion and tomato; sauté for 2 minutes.',
        'Add tastemaker and noodles.',
        'Cook for 3 minutes, stirring occasionally.',
        'Serve hot in a bowl.',
      ],
    ),
    Recipe(
      id: '3',
      name: 'Veg Sandwich',
      emoji: '🥪',
      cookTime: '15 min',
      ingredients: [
        '4 bread slices',
        'Butter as needed',
        '1 cucumber, sliced',
        '1 tomato, sliced',
        '1 onion, sliced',
        'Green chutney / ketchup',
        'Chaat masala (optional)',
      ],
      steps: [
        'Toast or butter the bread slices.',
        'Spread chutney or ketchup on one side.',
        'Layer cucumber, tomato and onion slices.',
        'Sprinkle chaat masala.',
        'Close the sandwich, cut diagonally and serve.',
      ],
    ),
    Recipe(
      id: '4',
      name: 'Masala Chai',
      emoji: '🍵',
      cookTime: '8 min',
      ingredients: [
        '1 cup water',
        '1/2 cup milk',
        '2 tsp sugar',
        '1.5 tsp tea leaves',
        '2 cardamom pods, crushed',
        'Small piece of ginger, crushed',
      ],
      steps: [
        'Boil water with ginger and cardamom.',
        'Add tea leaves and sugar; boil for 1 minute.',
        'Add milk and bring to a boil.',
        'Simmer for 2 minutes on low heat.',
        'Strain into cups and serve.',
      ],
    ),
  ];

  List<Recipe> get recipes => List.unmodifiable(_recipes);

  List<Recipe> get favorites =>
      _recipes.where((r) => r.isFavorite).toList(growable: false);

  Recipe? findById(String id) {
    try {
      return _recipes.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final index = _recipes.indexWhere((r) => r.id == id);
    if (index != -1) {
      _recipes[index].isFavorite = !_recipes[index].isFavorite;
      notifyListeners();
    }
  }

  void deleteRecipe(String id) {
    _recipes.removeWhere((r) => r.id == id);
    notifyListeners();
  }
}
