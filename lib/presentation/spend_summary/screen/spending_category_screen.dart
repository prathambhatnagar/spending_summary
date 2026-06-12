import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_summary/data/mock_trasactions_data.dart';
import 'package:spending_summary/presentation/spend_summary/proivder/spend_summary_provider.dart';
import 'package:spending_summary/presentation/spend_summary/screen/add_transactions_screen.dart';
import 'package:spending_summary/presentation/spend_summary/widgets/category_selection.dart';
import 'package:spending_summary/presentation/spend_summary/widgets/monthly_card.dart';
import 'package:spending_summary/presentation/spend_summary/widgets/transactions_tile.dart';

class SpendingCategoryScreen extends StatelessWidget {
  const SpendingCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<SpendSummaryProvider>(
              builder: (context, value, child) {
                return MonthlySpendCard(
                  currentMonthSpend: value.currentMonthSpend,
                  percentageChange: value.previousMonthSpend,
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 12),

            CategoriesSection(categories: categories),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Transactions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Consumer<SpendSummaryProvider>(
                builder: (context, value, child) {
                  final transactions = value.filteredTransactions;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: transactions.length,
                    itemBuilder: (context, index) =>
                        TransactionTile(transaction: transactions[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
