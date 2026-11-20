import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:recipe_book_app/main.dart';
import 'package:recipe_book_app/models/recipe.dart';
import 'package:recipe_book_app/screens/home_screen.dart';
import 'package:recipe_book_app/state/recipe_provider.dart';

void main() {
  RecipeProvider providerFrom(WidgetTester tester) {
    final context = tester.element(find.byType(HomeScreen));
    return Provider.of<RecipeProvider>(context, listen: false);
  }

  Future<void> scrollUntilVisible(
    WidgetTester tester,
    Finder finder, {
    Finder? scrollable,
  }) async {
    await tester.scrollUntilVisible(
      finder,
      200,
      scrollable: scrollable ?? find.byType(Scrollable).first,
    );
  }

  testWidgets('Home screen shows seeded recipes', (tester) async {
    await tester.pumpWidget(const RecipeBookApp());

    expect(find.text('Recipe Book'), findsOneWidget);
    expect(find.text('Paneer Butter Masala'), findsOneWidget);
    expect(find.text('Masala Maggi'), findsOneWidget);
    expect(find.text('Add Recipe'), findsOneWidget);
    expect(find.byTooltip('Favorites'), findsOneWidget);
  });

  testWidgets('Add recipe flow creates a new recipe', (tester) async {
    await tester.pumpWidget(const RecipeBookApp());

    final provider = providerFrom(tester);
    final initialCount = provider.recipes.length;

    await tester.tap(find.text('Add Recipe'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Recipe Name'),
      'Aloo Paratha',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Cook Time (e.g. 30 min)'),
      '25 min',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Ingredients (one per line)'),
      '2 cups flour\n2 boiled potatoes',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Steps (one per line)'),
      'Knead dough\nStuff and roll\nCook on tawa',
    );

    final saveFinder = find.text('Save Recipe');
    await scrollUntilVisible(tester, saveFinder);
    await tester.ensureVisible(saveFinder);
    await tester.pumpAndSettle();
    await tester.tap(saveFinder);
    await tester.pumpAndSettle();

    expect(provider.recipes.length, initialCount + 1);
    expect(provider.recipes.any((r) => r.name == 'Aloo Paratha'), isTrue);
    expect(find.text('Aloo Paratha'), findsOneWidget);
  });

  testWidgets('Open recipe detail from list', (tester) async {
    await tester.pumpWidget(const RecipeBookApp());

    await tester.tap(find.text('Paneer Butter Masala'));
    await tester.pumpAndSettle();

    expect(find.text('Recipe Details'), findsOneWidget);
    expect(find.text('Ingredients'), findsOneWidget);
    expect(find.text('Steps'), findsOneWidget);
    expect(find.text('200g paneer, cubed'), findsOneWidget);
    expect(find.text('Heat butter in a pan and sauté onions until golden.'),
        findsOneWidget);
  });

  testWidgets('Toggle favorite and see it on Favorites screen',
      (tester) async {
    await tester.pumpWidget(const RecipeBookApp());
    final provider = providerFrom(tester);

    // Tap heart on first recipe card (not the AppBar icon)
    final cardHeart = find
        .descendant(
          of: find.byType(RecipeCard).first,
          matching: find.byIcon(Icons.favorite_border),
        )
        .first;
    await tester.tap(cardHeart);
    await tester.pumpAndSettle();

    expect(provider.favorites.length, 1);
    expect(provider.favorites.first.name, 'Paneer Butter Masala');

    // Open favorites screen via AppBar tooltip
    await tester.tap(find.byTooltip('Favorites'));
    await tester.pumpAndSettle();

    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Paneer Butter Masala'), findsOneWidget);
  });

  test('RecipeProvider toggleFavorite flips flag', () {
    final provider = RecipeProvider();
    final id = provider.recipes.first.id;
    expect(provider.favorites, isEmpty);

    provider.toggleFavorite(id);
    expect(provider.favorites.length, 1);

    provider.toggleFavorite(id);
    expect(provider.favorites, isEmpty);
  });

  test('Recipe copyWith keeps id and updates fields', () {
    final recipe = Recipe(
      id: 'x',
      name: 'Old',
      emoji: '🍲',
      cookTime: '10 min',
      ingredients: ['a'],
      steps: ['b'],
    );
    final updated = recipe.copyWith(name: 'New', isFavorite: true);
    expect(updated.id, 'x');
    expect(updated.name, 'New');
    expect(updated.isFavorite, isTrue);
    expect(updated.ingredients, ['a']);
  });
}
