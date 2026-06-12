import 'package:spending_summary/data/service/transaction_service.dart';
import 'package:spending_summary/domain/entity/transaction_entity.dart';

abstract class TransactionRepository {
  List<TransactionEntity> getTransactions();
}

class TransactionRepositoryImpl extends TransactionRepository {
  TransactionRepositoryImpl({required this.transactionService});

  TransactionService transactionService;
  @override
  List<TransactionEntity> getTransactions() {
    final transactionModels = transactionService.getTransactions();
    return transactionModels.map((model) => model.toEntity()).toList();
  }
}
