import 'package:flutter/material.dart';
import 'package:testdrive/product.dart';
import 'package:testdrive/recipe.dart';

import 'ingredient-list.dart';

class ProductList extends StatefulWidget {
  ProductList(this.products);
  final List<Product> products;

  @override
  State<StatefulWidget> createState() {
    return ProductListState(this.products);
  }
}

class ProductListState extends State<ProductList> {
  ProductListState(this.products);
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return _buildProducts();
  }

  Widget _buildProducts() {
    return ListView.builder(
      itemCount: this.products.length,
      itemBuilder: (context, i) {
        return _buildRow(this.products[i]);
      });
  }
  
  Widget _buildRow(Product product) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
      leading: Container(
        child: Image.network(
          product.pictureUrl,
          width: 127,
        )
      ),
      title: Text(product.name)
    );
  }

}