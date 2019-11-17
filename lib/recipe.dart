class Recipe {
  final String name;
  final String pictureUrl;
  final List<Ingredient> ingredients;

  Recipe(this.name, this.pictureUrl, this.ingredients);

  Recipe.fromJson(var json)
    : name = json['name'],
      pictureUrl = json['pictureUrls'][0]['url'] + '?w=150&h=150&fit=clip',
      ingredients = _flattenIngredients(List.from(json['ingredients']));

  static List<Ingredient> _flattenIngredients(List subsections) {
    List<Ingredient> ingredients = [];
    for (var i = 0; i < subsections.length; i++) {
      List subsectionIngredients = subsections[i]['subSectionIngredients'];
      for (var j = 0; j < subsectionIngredients.length; j++) {
        var item = subsectionIngredients[j][0];
        ingredients.add(
          new Ingredient(
            item['name'],
            item['ingredientTypeName'],
            item['ingredientType'],
            false
          )
        );
      }
    }
    return ingredients;
  }
}

class Ingredient {
  final String name;
  final String typeName;
  final String typeId;
  bool bought;

  Ingredient(this.name, this.typeName, this.typeId, this.bought);
}