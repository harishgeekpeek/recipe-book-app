# Recipe Book App

Mini project for **App Development Lab (MCA Sem III)** — a small collection of recipes.

## Features

- **Home screen** — list of recipes with emoji, cook time and ingredient count
- **Recipe details** — ingredients + numbered cooking steps, favorite toggle
- **Add recipe** — name, cook time, ingredients and steps (one per line), emoji picker
- **Favorites** — separate screen listing all favorited recipes

Expected output flow: *User views recipe list → opens a recipe → marks it favorite → sees favorites list.*

## Screens

| # | Screen | File |
|---|--------|------|
| 1 | Recipe list (home) | `lib/screens/home_screen.dart` |
| 2 | Recipe details / favorite | `lib/screens/recipe_detail_screen.dart` |
| 3 | Add recipe | `lib/screens/add_recipe_screen.dart` |
| 4 | Favorites | `lib/screens/favorites_screen.dart` |

## Tech

- Flutter 3.50 (Material 3)
- `provider` for state management
- In-memory store (no database required for this lab)

## Run

```bash
flutter pub get
flutter run            # device / emulator
flutter run -d chrome  # web
flutter test           # widget + unit tests
```

## Team

- Ayushi Chhangani
