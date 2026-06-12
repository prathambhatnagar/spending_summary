import 'package:spending_summary/data/models/transactions/transactions_categories_model.dart';
import 'package:spending_summary/domain/entity/transaction_entity.dart';

class TransactionModel {
  TransactionModel({
    required this.id,
    required this.note,
    required this.amount,
    required this.type,
    required this.timeStamp,
    this.category,
  });

  String id;
  TransactionTypeModel type;
  double amount;
  String note;
  DateTime timeStamp;
  TransactionsCategoriesModel? category;

  factory TransactionModel.fromEntity({
    required TransactionEntity transactionEntity,
  }) {
    return TransactionModel(
      id: transactionEntity.id,
      note: transactionEntity.note,
      amount: transactionEntity.amount,
      type: transactionEntity.type == TransactionTypeEntity.income
          ? TransactionTypeModel.income
          : TransactionTypeModel.expense,
      timeStamp: transactionEntity.timeStamp,
      category: transactionEntity.category != null
          ? TransactionsCategoriesModel.fromEntity(
              categoryEntity: transactionEntity.category!,
            )
          : null,
    );
  }
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      note: note,
      amount: amount,
      type: type == TransactionTypeModel.income
          ? TransactionTypeEntity.income
          : TransactionTypeEntity.expense,
      timeStamp: timeStamp,
      category: category?.toEntity(),
    );
  }
}

enum TransactionTypeModel { income, expense }
