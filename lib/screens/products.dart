import 'package:flutter/material.dart';
import 'package:t3_shopping_list/models/product.dart';
import 'package:t3_shopping_list/providers/products_data.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Products'),
      ), // AppBar
      body: FutureBuilder(
        future: ProductsData.loadJson(context, 'assets/json/products.json'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return _ProductsListView(ProductsData.fromJson(snapshot.data!));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ), // FutureBuilder
    ); // Scaffold
  }
}
class _ProductsListView extends StatelessWidget {
  final ProductsData _productsData;

  const _ProductsListView(this._productsData);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _productsData.getSize(),
      itemBuilder: (context, index) =>
          _listItem(context, _productsData.getProduct(index)),
    ); // ListView.builder
  }

  Widget _listItem(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: () {},
        leading: Image.asset(product.image, width: 100.0, height: 100.0, fit: BoxFit.contain, alignment: Alignment.bottomCenter),
        trailing: const Icon(Icons.shopping_bag),
        title: Text(product.name),
        subtitle: Text('${product.price}€'),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.indigo),
          borderRadius: BorderRadius.circular(10.0),
        ), // RoundedRectangleBorder
      ), // ListTile
    ); // Padding
  }
}
