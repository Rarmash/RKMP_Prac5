import 'package:flutter/material.dart';
import '../services/data_service.dart';

class StockManageScreen extends StatefulWidget {
  final DataService dataService;
  const StockManageScreen({super.key, required this.dataService});

  @override
  State<StockManageScreen> createState() => _StockManageScreenState();
}

class _StockManageScreenState extends State<StockManageScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  String? infoMessage;

  void _addOrRestock() {
    final name = nameController.text.trim();
    final quantity = int.tryParse(quantityController.text) ?? 0;

    if (name.isEmpty || quantity <= 0) return;

    setState(() {
      final existing = widget.dataService.products
          .any((p) => p.name.toLowerCase() == name.toLowerCase());
      widget.dataService.addOrRestockProduct(name, quantity);
      infoMessage = existing
          ? 'Запас товара "$name" пополнен на $quantity шт.'
          : 'Добавлен новый товар "$name" ($quantity шт.)';
    });

    nameController.clear();
    quantityController.clear();
  }

  void _removeProduct(int id) {
    setState(() {
      widget.dataService.removeProduct(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.dataService.products;

    return Scaffold(
      appBar: AppBar(title: const Text('Управление складом')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Название товара'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Количество'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addOrRestock,
              child: const Text('Добавить / Пополнить товар'),
            ),
            if (infoMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                infoMessage!,
                style: const TextStyle(color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ],
            const Divider(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('Количество: ${product.quantity} шт.'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeProduct(product.id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
