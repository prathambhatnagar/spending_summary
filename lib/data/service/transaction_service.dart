import 'package:spending_summary/data/mock_trasactions_data.dart';
import 'package:spending_summary/data/models/transactions/transactions_model.dart';

abstract class TransactionService {
  List<TransactionModel> getTransactions();
}

class TransactionServiceImpl extends TransactionService {
  @override
  List<TransactionModel> getTransactions() {
    return generateMockTransactions(count: 57);
  }
}
