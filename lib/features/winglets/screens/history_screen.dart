import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../../../utils/format_utils.dart';

class HistoryScreen extends StatelessWidget {
  final DataService dataService;
  const HistoryScreen({super.key, required this.dataService});

  @override
  Widget build(BuildContext context) {
    final history = dataService.history;

    return Scaffold(
      appBar: AppBar(title: const Text('История заказов')),
      body: history.isEmpty
          ? const Center(child: Text('История заказов пуста'))
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: Text(item['name']),
            subtitle: Text(
              'Количество: ${item['quantity']} • ${formatDate(item['date'])}',
            ),
          );
        },
      ),
    );
  }
}
