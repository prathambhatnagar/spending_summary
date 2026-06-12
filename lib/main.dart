import 'package:flutter/material.dart';
import 'package:spending_summary/data/mock_trasactions_data.dart';

void main() {
  runApp(MyApp());

  final list = generateMockTransactions(categories: spendingCategories);
  print(list.length);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Material();
  }
}
