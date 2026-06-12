import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_summary/data/repository/transaction_repository.dart';
import 'package:spending_summary/data/service/transaction_service.dart';
import 'package:spending_summary/presentation/spend_summary/proivder/spend_summary_provider.dart';
import 'package:spending_summary/presentation/spend_summary/screen/spending_category_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SpendSummaryProvider(
        transactionRepository: TransactionRepositoryImpl(
          transactionService: TransactionServiceImpl(),
        ),
      )..loadTransactions(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SpendingCategoryScreen(),
      ),
    );
  }
}
