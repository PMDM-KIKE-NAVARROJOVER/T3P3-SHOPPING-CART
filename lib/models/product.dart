class Product {
  int id;
  String name;
  double price;
  String category;
  String image;
  String description;

  Product(this.id, this.name, this.price, this.category, this.image,
      this.description);

  // returns new instance of product with map data
  factory Product.fromMap(Map<String, dynamic> map) => Product(
      map['id'],
      map['name'],
      map['price'],
      map['category'],
      map['image'],
      map['description']);
}