import '../models/product.dart';

class DataService {
  final List<Product> _products = [
    Product(id: 1, name: 'Подкрылок передний', quantity: 10),
    Product(id: 2, name: 'Подкрылок задний', quantity: 7),
    Product(id: 3, name: 'Подкрылок универсальный', quantity: 5),
  ];

  final List<Map<String, dynamic>> _history = [];

  List<Product> get products => _products;
  List<Map<String, dynamic>> get history => _history;

  void addOrRestockProduct(String name, int quantity) {
    final existing =
    _products.where((p) => p.name.toLowerCase() == name.toLowerCase());
    if (existing.isNotEmpty) {
      final product = existing.first;
      product.quantity += quantity;
    } else {
      final newId = _products.isNotEmpty ? _products.last.id + 1 : 1;
      _products.add(Product(id: newId, name: name, quantity: quantity));
    }
  }

  void removeProduct(int id) {
    _products.removeWhere((product) => product.id == id);
  }

  bool updateQuantity(int id, int count) {
    for (var p in _products) {
      if (p.id == id) {
        if (count > p.quantity) {
          return false;
        }
        p.quantity -= count;
        return true;
      }
    }
    return false;
  }

  Product? findById(int id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  void addToHistory(Map<String, dynamic> order) {
    _history.add(order);
  }
}
