import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'state/recipe_provider.dart';

void main() {
  runApp(const RecipeBookApp());
}

class RecipeBookApp extends StatelessWidget {
  const RecipeBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeProvider(),
      child: MaterialApp(
        title: 'Recipe Book',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: true),
          cardTheme: CardThemeData(
            clipBehavior: Clip.antiAlias,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
