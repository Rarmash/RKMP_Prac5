class Product {
  final int id;
  String name;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
  });

  Map<String, dynamic> toMap() =>
      {'id': id, 'name': name, 'quantity': quantity};

  static Product fromMap(Map<String, dynamic> map) => Product(
    id: map['id'],
    name: map['name'],
    quantity: map['quantity'],
  );
}
