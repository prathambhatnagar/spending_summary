import 'package:spending_summary/domain/entity/transaction_category_entity.dart';

class TransactionEntity {
  const TransactionEntity({
    required this.id,
    required this.note,
    required this.amount,
    required this.type,
    required this.timeStamp,
    this.category,
  });

  final String id;
  final TransactionTypeEntity type;
  final double amount;
  final String note;
  final DateTime timeStamp;
  final TransactionCategoryEntity? category;
}

enum TransactionTypeEntity { income, expense }
