import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:t3_shopping_list/models/product.dart';

enum OrderBy {id, name, category, price}

class ProductsData {
  final List<Product> _products;

  // private named constructor
  ProductsData._(this._products);

  // Factory constructor: returns instance of ProductData from a json String
  factory ProductsData.fromJson(String jsonData, {OrderBy orderBy = OrderBy.name}) {
    // Convert json String to a map (Json object)
    Map<String, dynamic> mapJson = json.decode(jsonData);

    // get "products" key: list of json objects
    List<dynamic> list = mapJson["products"];

    // create list of products from json list
    List<Product> productsList = list.map((element) => Product.fromMap(element)).toList();

    // sort products (default, by name)
    _sortList(productsList, orderBy);

    // return ProductsData instance with productsList
    return ProductsData._(productsList);
  }

  // getters
  Product getProduct(int index) => _products[index];
  int getSize() => _products.length; // (or getSize() based on exact text)

  // static utils
  // load local json file using loadString
  static Future<String> loadJson(BuildContext context, String file) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate that operation takes some time to load
    return await DefaultAssetBundle.of(context).loadString(file);
  }

  static _sortList(List<Product> list, OrderBy orderBy) {
    switch(orderBy) {
      case OrderBy.id:
        list.sort((prodA, prodB) => prodA.id.compareTo(prodB.id));
        break;
      case OrderBy.name:
        list.sort((prodA, prodB) => prodA.name.compareTo(prodB.name));
        break;
      case OrderBy.category:
        list.sort((prodA, prodB) => prodA.category.compareTo(prodB.category));
        break;
      case OrderBy.price:
        list.sort((prodA, prodB) => prodA.price.compareTo(prodB.price));
        break;
    }
  }
}
