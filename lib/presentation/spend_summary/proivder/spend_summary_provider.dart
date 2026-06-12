import 'package:flutter/material.dart';
import 'package:spending_summary/data/repository/transaction_repository.dart';
import 'package:spending_summary/domain/entity/transaction_category_entity.dart';
import 'package:spending_summary/domain/entity/transaction_entity.dart';

class SpendSummaryProvider extends ChangeNotifier {
  SpendSummaryProvider({required this.transactionRepository});

  final TransactionRepository transactionRepository;

  List<TransactionEntity> _transactions = [];

  TransactionCategoryEntity? _selectedCategory;

  List<TransactionEntity> get transactions => _transactions;

  TransactionCategoryEntity? get selectedCategory => _selectedCategory;

  Future<void> loadTransactions() async {
    _transactions = transactionRepository.getTransactions();

    notifyListeners();
  }

  void selectCategory(TransactionCategoryEntity? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<TransactionEntity> get filteredTransactions {
    if (_selectedCategory == null) {
      return _transactions;
    }

    return _transactions.where((transaction) {
      return transaction.category?.id == _selectedCategory!.id;
    }).toList();
  }

  double getCategorySpend(TransactionCategoryEntity category) {
    return _transactions
        .where((transaction) => transaction.category?.id == category.id)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double get currentMonthSpend {
    final now = DateTime.now();

    return _transactions
        .where(
          (e) => e.timeStamp.month == now.month && e.timeStamp.year == now.year,
        )
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  double get previousMonthSpend {
    final now = DateTime.now();

    final month = now.month == 1 ? 12 : now.month - 1;

    final year = now.month == 1 ? now.year - 1 : now.year;

    return _transactions
        .where((e) => e.timeStamp.month == month && e.timeStamp.year == year)
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  double get percentageChange {
    if (previousMonthSpend == 0) return 0;

    return ((currentMonthSpend - previousMonthSpend) / previousMonthSpend) *
        100;
  }

  void addTransaction(TransactionEntity transaction) {
    _transactions.insert(0, transaction);
    notifyListeners();
  }
}
