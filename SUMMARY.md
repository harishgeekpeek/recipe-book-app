# Mini Project Summary — Recipe Book App

**Course:** App Development Lab (MCA Sem III)  
**Project Title:** Recipe Book App  
**Team:** Individual

| Member |
|--------|
| Ayushi Chhangani |

---

## 1. Overview

A mobile application that stores a small collection of recipes. The home screen
shows a recipe list; opening a recipe displays its ingredients and steps. Users
can add new recipes, mark recipes as favorites, and view all favorites on a
separate screen.

**Expected output (per lab handout):**  
*User views recipe list → opens a recipe → marks it favorite → sees favorites list.* ✓

## 2. Features

| # | Feature | Screen |
|---|---------|--------|
| 1 | Browse recipes (name, emoji, cook time, ingredient count) | Home / Recipe List |
| 2 | View ingredients and numbered cooking steps | Recipe Details |
| 3 | Mark / unmark a recipe as favorite (♥) | Details + list cards |
| 4 | View all favorite recipes in one place | Favorites |
| 5 | Add a new recipe with form validation | Add Recipe |

- Empty-state messages for list and favorites  
- Material 3 UI with deep-orange (food) theme  
- Snackbar feedback on add  

## 3. Technology Stack

| Layer | Choice |
|-------|--------|
| Framework | Flutter 3.50 (Dart 3.14) |
| State management | `provider` (`ChangeNotifier`) |
| UI | Material 3 widgets |
| Data storage | In-memory list (database not compulsory for this lab) |

## 4. Project Structure

```
lib/
├── main.dart                    # App entry + theme + provider setup
├── models/recipe.dart           # Recipe data model
├── state/recipe_provider.dart   # add, toggleFavorite, favorites, findById
└── screens/
    ├── home_screen.dart         # Recipe list
    ├── recipe_detail_screen.dart# Ingredients + steps + favorite toggle
    ├── add_recipe_screen.dart   # Add recipe form
    └── favorites_screen.dart    # Favorited recipes
```

## 5. How It Works

1. **RecipeProvider** holds a `List<Recipe>` and exposes `addRecipe`,
   `toggleFavorite`, `findById`, and a `favorites` getter. It extends
   `ChangeNotifier` so the UI rebuilds automatically.
2. **HomeScreen** uses `Consumer<RecipeProvider>` to render the recipe list;
   each card has a heart icon to toggle favorite.
3. Tapping a card opens **RecipeDetailScreen** (ingredients + steps).
4. **AddRecipeScreen** validates the form, splits ingredients/steps by newline,
   calls `addRecipe`, and pops back to the updated list.
5. **FavoritesScreen** filters recipes where `isFavorite == true`.

## 6. Testing & Verification

- `flutter analyze` — 0 issues  
- `flutter test` — 6/6 passed (list rendering, add flow, detail navigation,
  favorite toggle + favorites screen, provider logic, model `copyWith`)  
- `flutter build web` — successful production build  

## 7. How to Run

```bash
flutter pub get
flutter run            # emulator / device
flutter run -d chrome  # browser
flutter test           # run test suite
```

## 8. Limitations & Future Scope

- Data is in-memory (resets on app restart) → can add `shared_preferences`
  or SQLite/Hive for persistence  
- Could add recipe images, categories, and search later  

---

*Submitted as part of App Development Lab mini project requirement.*
