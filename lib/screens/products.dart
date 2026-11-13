import 'package:flutter/material.dart';
import 'package:t3_shopping_list/models/product.dart';
import 'package:t3_shopping_list/providers/products_data.dart';
import 'package:t3_shopping_list/screens/cart.dart';
import 'package:t3_shopping_list/screens/product_detail.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // Mapa que almacena el Producto y la cantidad seleccionada
  final Map<Product, int> _cart = {};
  late Future<String> _productsFuture;

  @override
  void initState() {
    super.initState();
    // Guardamos el Future en initState para que no se recargue el JSON al hacer setState
    _productsFuture = ProductsData.loadJson(context, 'assets/json/products.json');
  }

  void _toggleProductInCart(Product product) {
    setState(() {
      if (_cart.containsKey(product)) {
        _cart.remove(product);
      } else {
        _cart[product] = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Products'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                tooltip: 'Ver carrito',
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cart: _cart),
                    ),
                  );
                  // Al volver del carrito, actualizamos la vista por si se eliminó algún ítem
                  setState(() {});
                },
              ),
              if (_cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${_cart.length}',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: _productsFuture,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return _ProductsListView(
              productsData: ProductsData.fromJson(snapshot.data!),
              cart: _cart,
              onToggleCart: _toggleProductInCart,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _ProductsListView extends StatelessWidget {
  final ProductsData productsData;
  final Map<Product, int> cart;
  final Function(Product) onToggleCart;

  const _ProductsListView({
    required this.productsData,
    required this.cart,
    required this.onToggleCart,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productsData.getSize(),
      itemBuilder: (context, index) =>
          _listItem(context, productsData.getProduct(index)),
    );
  }

  Widget _listItem(BuildContext context, Product product) {
    final bool isSelected = cart.containsKey(product);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetail(product.id, product.name, product.description),
          ),
        ),
        leading: Image.asset(
          product.image,
          width: 100.0,
          height: 100.0,
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.shopping_bag,
            color: isSelected ? Colors.indigo : Colors.grey,
            size: 30.0,
          ),
          onPressed: () => onToggleCart(product),
        ),
        title: Text(product.name),
        subtitle: Text('${product.price.toStringAsFixed(2)}€'),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isSelected ? Colors.indigo : Colors.grey.shade400,
            width: isSelected ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}