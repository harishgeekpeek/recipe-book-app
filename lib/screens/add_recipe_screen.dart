import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../state/recipe_provider.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cookTimeController = TextEditingController(text: '30 min');
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  String _emoji = '🍲';

  static const _emojiOptions = ['🍲', '🍜', '🥪', '🍵', '🥗', '🍕', '🎂', '🍛'];

  @override
  void dispose() {
    _nameController.dispose();
    _cookTimeController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

  List<String> _splitLines(String text) => text
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final recipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      emoji: _emoji,
      cookTime: _cookTimeController.text.trim(),
      ingredients: _splitLines(_ingredientsController.text),
      steps: _splitLines(_stepsController.text),
    );
    context.read<RecipeProvider>().addRecipe(recipe);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${recipe.name}" added')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Recipe')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  for (final e in _emojiOptions)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ChoiceChip(
                        label: Text(e, style: const TextStyle(fontSize: 18)),
                        selected: _emoji == e,
                        onSelected: (_) => setState(() => _emoji = e),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Recipe Name',
                  prefixIcon: Icon(Icons.restaurant),
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter recipe name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cookTimeController,
                decoration: const InputDecoration(
                  labelText: 'Cook Time (e.g. 30 min)',
                  prefixIcon: Icon(Icons.timer_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter cook time' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ingredientsController,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Ingredients (one per line)',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.shopping_basket),
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (_splitLines(v ?? '').isEmpty)
                    ? 'Enter at least one ingredient'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stepsController,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Steps (one per line)',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.list_alt),
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (_splitLines(v ?? '').isEmpty)
                    ? 'Enter at least one step'
                    : null,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.check),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text('Save Recipe', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
