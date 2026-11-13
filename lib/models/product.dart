class Product {
  int id;
  String name;
  double price;
  String category;
  String image;
  String description;

  Product(this.id, this.name, this.price, this.category, this.image,
      this.description);

  factory Product.fromMap(Map<String, dynamic> map) => Product(
      map['id'],
      map['name'],
      (map['price'] as num).toDouble(),
      map['category'],
      map['image'],
      map['description']);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}