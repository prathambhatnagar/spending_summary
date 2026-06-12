import 'dart:math';

import 'package:spending_summary/data/models/transactions/transactions_categories_model.dart';
import 'package:spending_summary/data/models/transactions/transactions_model.dart';
import 'package:spending_summary/domain/entity/transaction_category_entity.dart';

List<TransactionModel> generateMockTransactions({int count = 57}) {
  final random = Random();

  final notes = [
    'Monthly Rent',
    'Electricity Bill',
    'Water Bill',
    'Internet Recharge',
    'Grocery Shopping',
    'Fuel',
    'Movie Tickets',
    'Amazon Order',
    'Flight Booking',
    'Doctor Visit',
    'Gym Membership',
    'Course Purchase',
    'Restaurant',
    'Coffee',
    'Cab Ride',
    'Phone Recharge',
    'Insurance Payment',
    'Clothing Purchase',
    'Book Purchase',
    'Emergency Expense',
  ];

  return List.generate(count, (index) {
    final category = categories[random.nextInt(categories.length)];

    return TransactionModel(
      id: 'txn_${index + 1}',
      note: notes[random.nextInt(notes.length)],
      amount: (random.nextDouble() * 15000 + 100).roundToDouble(),
      type: TransactionTypeModel.expense,
      timeStamp: DateTime.now().subtract(
        Duration(
          days: random.nextInt(90),
          hours: random.nextInt(24),
          minutes: random.nextInt(60),
        ),
      ),
      category: TransactionsCategoriesModel.fromEntity(
        categoryEntity: category,
      ),
    );
  });
}

final List<TransactionCategoryEntity> categories = [
  TransactionCategoryEntity(
    id: '1',
    name: 'Housing',
    iconPath: '',
    colorHex: 0xFFFF6B6B,
  ),
  TransactionCategoryEntity(
    id: '2',
    name: 'Utilities',
    iconPath: '',
    colorHex: 0xFF4ECDC4,
  ),
  TransactionCategoryEntity(
    id: '3',
    name: 'Groceries',
    iconPath: '',
    colorHex: 0xFF45B7D1,
  ),
  TransactionCategoryEntity(
    id: '4',
    name: 'Transport',
    iconPath: '',
    colorHex: 0xFFFFA07A,
  ),
  TransactionCategoryEntity(
    id: '5',
    name: 'Entertainment',
    iconPath: '',
    colorHex: 0xFFC7CEEA,
  ),
  TransactionCategoryEntity(
    id: '6',
    name: 'Shopping',
    iconPath: '',
    colorHex: 0xFFFFB347,
  ),
  TransactionCategoryEntity(
    id: '7',
    name: 'Travel',
    iconPath: '',
    colorHex: 0xFF77DD77,
  ),
  TransactionCategoryEntity(
    id: '8',
    name: 'Health',
    iconPath: '',
    colorHex: 0xFFFF6961,
  ),
  TransactionCategoryEntity(
    id: '9',
    name: 'Education',
    iconPath: '',
    colorHex: 0xFFAEC6CF,
  ),
  TransactionCategoryEntity(
    id: '10',
    name: 'Savings',
    iconPath: '',
    colorHex: 0xFFFDFD96,
  ),
  TransactionCategoryEntity(
    id: '11',
    name: 'Miscellaneous',
    iconPath: '',
    colorHex: 0xFFB39EB5,
  ),
];
