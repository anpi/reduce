import 'package:flutter/material.dart';
import 'package:testdrive/recipe.dart';

class IngredientList extends StatefulWidget {
  IngredientList(this.recipe);

  final Recipe recipe;

  @override
  State<StatefulWidget> createState() {
    return IngredientListState(this.recipe);
  }
}

class IngredientListState extends State<IngredientList> {
  IngredientListState(this.recipe);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.recipe.name),
        backgroundColor: Color(0xFFff6900)
      ),
      body: ListView.builder(
        itemCount: this.recipe.ingredients.length,
        itemBuilder: (context, i) {
          return _buildRow(this.recipe.ingredients[i]);
        },
      )
    );
  }

  Widget _buildRow(Ingredient ingredient) {
    return CheckboxListTile(
      title: Text(ingredient.name),
      value: ingredient.bought,
      onChanged: (bool value) {
        setState(() {
          ingredient.bought = value;
        });
      },
    );
  }
}