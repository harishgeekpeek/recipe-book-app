class Recipe {
  final String id;
  final String name;
  final String emoji;
  final String cookTime;
  final List<String> ingredients;
  final List<String> steps;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.emoji,
    required this.cookTime,
    required this.ingredients,
    required this.steps,
    this.isFavorite = false,
  });

  Recipe copyWith({
    String? name,
    String? emoji,
    String? cookTime,
    List<String>? ingredients,
    List<String>? steps,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      cookTime: cookTime ?? this.cookTime,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
