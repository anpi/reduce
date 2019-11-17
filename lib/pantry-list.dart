import 'package:flutter/material.dart';
import 'package:testdrive/product-list.dart';
import 'package:testdrive/product.dart';

class PantryList extends StatefulWidget {
  final Future<List<Product>> productsFuture;

  PantryList(this.productsFuture);

  @override
  State<StatefulWidget> createState() => new PantryListState(this.productsFuture);

}

class PantryListState extends State<PantryList> {
  final Future<List<Product>> productsFuture;

  PantryListState(this.productsFuture);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expiring products"),
        backgroundColor: Color(0xFFff6900)
      ),
      body: FutureBuilder<List<Product>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProductList(snapshot.data);
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
    );
  }

}