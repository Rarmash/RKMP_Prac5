import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../widgets/product_tile.dart';
import 'order_screen.dart';
import 'stock_manage_screen.dart';
import 'history_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final DataService _data = DataService();

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Каталог подкрылков')),
      body: ListView.builder(
        itemCount: _data.products.length,
        itemBuilder: (context, index) {
          return ProductTile(product: _data.products[index]);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Заказ'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderScreen(dataService: _data),
                    ),
                  ).then((_) => _refresh());
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.inventory),
                label: const Text('Склад'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StockManageScreen(dataService: _data),
                    ),
                  ).then((_) => _refresh());
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.history),
                label: const Text('История'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HistoryScreen(dataService: _data),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
