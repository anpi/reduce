import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testdrive/ingredient-list.dart';
import 'package:testdrive/pantry-list.dart';
import 'package:testdrive/product.dart';
import 'package:testdrive/recipe-list.dart';
import 'package:testdrive/recipe.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Recipe>> recipes;
  Future<List<Product>> products;

  Future<List<Recipe>> _fetchRecipes() async {
    final resp = await http.get('http://zalando-12431.local:8081/recipes?ingredients=suola');
    if (resp.statusCode == 200) {
      Map<String, dynamic> searchResult = jsonDecode(utf8.decode(resp.bodyBytes));
      var recipeJsons = List<dynamic>.from(searchResult['results']);
      List<Recipe> recipes = [];
      for (var i = 0; i < recipeJsons.length; i++) {
        recipes.add(Recipe.fromJson(recipeJsons[i]));
      }
      return recipes;
    } else {
      throw Exception('Failed fetching name');
    }
  }

  Future<List<Product>> _fetchProducts() async {
    final resp = await http.get('http://zalando-12431.local:8081/products');
    if (resp.statusCode == 200) {
      List<dynamic> productJson = jsonDecode(utf8.decode(resp.bodyBytes));
      List<Product> products = [];
      for (var i = 0; i < productJson.length; i++) {
        products.add(Product.fromJson(productJson[i]));
      }
      return products;
    } else {
      throw Exception('Failed fetching name');
    }
  }

  @override
  void initState() {
    super.initState();
    recipes = _fetchRecipes();
    products = _fetchProducts();
    _updatePurchases(recipes, products);
  }

  Future<void> _updatePurchases(Future<List<Recipe>> recipes, Future<List<Product>> products) async {
    List<Recipe> rs = await recipes;
    List<Product> ps = await products;
    List<String> types = [];
    for (final p in ps) {
      types.add(p.productType);
    }
    int comparisons = 0;
    int found = 0;
    List<String> stapleIngredients = ["6961", "6932", "6807", "7049", "7605",
      "5997", "6953", "5355", "6035", "5608", "5405", "5792", "7289", "6220",
      "7262", "6582", "6525"];
    for (final r in rs) {
      for (final ingredient in r.ingredients) {
        ingredient.bought = (stapleIngredients.contains(ingredient.typeId) ||
            types.contains(ingredient.typeId));
        comparisons++;
        if (ingredient.bought) {
          found++;
        }
      }
    }
    print(found);
    print(comparisons);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) =>
        Scaffold(
          appBar: AppBar(
            title: Text("Eat the perishables!"),
            backgroundColor: Color(0xFFff6900),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.list, color: Colors.white),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => PantryList(this.products)
                    )
                  );
                }
              ),
            ],
          ),
          body: FutureBuilder<List<Recipe>>(
            future: recipes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RecipeList(recipes: snapshot.data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(0xFFff6900)
                  )
                )
              );
            },
          )
        )
      )
    );
  }

}
