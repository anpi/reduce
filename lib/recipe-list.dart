import 'package:flutter/material.dart';
import 'package:testdrive/recipe.dart';

import 'ingredient-list.dart';

class RecipeList extends StatefulWidget {
  RecipeList({this.recipes});
  final List<Recipe> recipes;

  @override
  State<StatefulWidget> createState() {
    return RecipeListState(recipes: this.recipes);
  }
}

class RecipeListState extends State<RecipeList> {
  RecipeListState({this.recipes});
  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    return _buildRecipes();
  }

  Widget _buildRecipes() {
    return ListView.builder(
      itemCount: this.recipes.length,
      itemBuilder: (context, i) {
        return _buildRow(this.recipes[i]);
      }
    );
  }
  
  Widget _buildRow(Recipe recipe) {
    int icon = 58133;
    int count = recipe.ingredients.fold(0, (val, i) { if (i.bought) return val + 1; else return val; });
    if (count > 9) {
      icon = 59383;
    } else if (count > 7) {
      icon = 59380;
    }
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
      leading: Container(
        child: Image.network(
          recipe.pictureUrl,
          width: 127,
        )
      ),
      title: Text(recipe.name),
      trailing: Icon(IconData(icon, fontFamily: 'MaterialIcons')),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => IngredientList(recipe)
        ));
      },
    );
  }

}