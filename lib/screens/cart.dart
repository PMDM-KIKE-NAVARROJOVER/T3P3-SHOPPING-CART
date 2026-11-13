import 'package:flutter/material.dart';
import 'package:t3_shopping_list/models/product.dart';

class CartScreen extends StatefulWidget {
  final Map<Product, int> cart;

  const CartScreen({Key? key, required this.cart}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    // Calculamos el importe inicial al abrir el carrito
    _updateTotal();
  }

  // Método dedicado que calcula el total y actualiza el estado de la interfaz
  void _updateTotal() {
    double total = 0.0;
    widget.cart.forEach((product, quantity) {
      total += product.price * quantity;
    });

    setState(() {
      _totalAmount = total;
    });
  }

  void _incrementQuantity(Product product) {
    widget.cart[product] = (widget.cart[product] ?? 0) + 1;
    _updateTotal(); // Actualiza la interfaz y el total en la AppBar
  }

  void _decrementQuantity(Product product) {
    final currentQty = widget.cart[product] ?? 0;
    if (currentQty > 1) {
      widget.cart[product] = currentQty - 1;
    } else {
      widget.cart.remove(product);
    }
    _updateTotal(); // Actualiza la interfaz y el total en la AppBar
  }

  @override
  Widget build(BuildContext context) {
    final selectedProducts = widget.cart.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shopping Cart'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Total: ${_totalAmount.toStringAsFixed(2)}€',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: selectedProducts.isEmpty
          ? const Center(
        child: Text(
          'Your cart is empty.',
          style: TextStyle(fontSize: 18.0, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: selectedProducts.length,
        itemBuilder: (context, index) {
          final product = selectedProducts[index];
          final quantity = widget.cart[product]!;
          final subtotal = product.price * quantity;

          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 6.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.indigo),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: Image.asset(
                  product.image,
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.contain,
                ),
                title: Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${product.price.toStringAsFixed(2)}€ / ud.\nSubtotal: ${subtotal.toStringAsFixed(2)}€',
                ),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline,
                          color: Colors.red),
                      onPressed: () => _decrementQuantity(product),
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.green),
                      onPressed: () => _incrementQuantity(product),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}