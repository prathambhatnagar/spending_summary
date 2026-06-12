import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_summary/domain/entity/transaction_category_entity.dart';
import 'package:spending_summary/presentation/spend_summary/proivder/spend_summary_provider.dart';
import 'package:spending_summary/presentation/spend_summary/widgets/category_card.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key, required this.categories});

  final List<TransactionCategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SpendSummaryProvider>();

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return CategoryCard(
            category: category,
            amount: provider.getCategorySpend(category),
            isSelected: provider.selectedCategory?.id == category.id,
            onTap: () {
              provider.selectCategory(
                provider.selectedCategory?.id == category.id ? null : category,
              );
            },
          );
        },
      ),
    );
  }
}
