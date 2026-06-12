import 'package:flutter/material.dart';
import 'package:spending_summary/domain/entity/transaction_category_entity.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.amount,
    required this.isSelected,
    required this.onTap,
  });

  final TransactionCategoryEntity category;
  final double amount;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = Color(category.colorHex);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 80,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(5) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? color : Colors.grey.shade300),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(_getIcon(category.name), color: color, size: 22),

            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),

            Text(
              '₹${amount.toStringAsFixed(0)}',
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String category) {
    switch (category) {
      case 'Housing':
        return Icons.home_rounded;
      case 'Utilities':
        return Icons.bolt_rounded;
      case 'Groceries':
        return Icons.shopping_cart_rounded;
      case 'Transport':
        return Icons.directions_car_rounded;
      case 'Entertainment':
        return Icons.movie_rounded;
      case 'Shopping':
        return Icons.shopping_bag_rounded;
      case 'Travel':
        return Icons.flight_rounded;
      case 'Health':
        return Icons.favorite_rounded;
      case 'Education':
        return Icons.school_rounded;
      case 'Savings':
        return Icons.savings_rounded;
      default:
        return Icons.category_rounded;
    }
  }
}
