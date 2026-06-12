import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_summary/data/mock_trasactions_data.dart';
import 'package:spending_summary/domain/entity/transaction_category_entity.dart';
import 'package:spending_summary/domain/entity/transaction_entity.dart';
import 'package:spending_summary/presentation/spend_summary/proivder/spend_summary_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  final noteController = TextEditingController();

  TransactionCategoryEntity? selectedCategory;
  DateTime selectedDate = DateTime.now();

  bool isExpense = true;

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _saveTransaction() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }

    final transaction = TransactionEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      note: noteController.text.trim(),
      amount: double.parse(amountController.text),
      type: isExpense
          ? TransactionTypeEntity.expense
          : TransactionTypeEntity.income,
      timeStamp: selectedDate,
      category: selectedCategory,
    );

    context.read<SpendSummaryProvider>().addTransaction(transaction);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Transaction Type',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                  value: true,
                  label: Text('Expense'),
                  icon: Icon(Icons.arrow_upward),
                ),
                ButtonSegment(
                  value: false,
                  label: Text('Income'),
                  icon: Icon(Icons.arrow_downward),
                ),
              ],
              selected: {isExpense},
              onSelectionChanged: (value) {
                setState(() {
                  isExpense = value.first;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text('Date', style: TextStyle(fontWeight: FontWeight.w600)),

            const SizedBox(height: 8),

            InkWell(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text('Amount', style: TextStyle(fontWeight: FontWeight.w600)),

            const SizedBox(height: 8),

            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter amount',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter amount';
                }

                if (double.tryParse(value) == null) {
                  return 'Invalid amount';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<TransactionCategoryEntity>(
              value: selectedCategory,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text('Select Category'),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text('Note', style: TextStyle(fontWeight: FontWeight.w600)),

            const SizedBox(height: 8),

            TextFormField(
              controller: noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Add note',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _saveTransaction,
                child: const Text('Save Transaction'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
