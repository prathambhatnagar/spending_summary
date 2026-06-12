import 'package:spending_summary/domain/entity/transaction_category_entity.dart';

class TransactionsCategoriesModel {
  const TransactionsCategoriesModel({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.colorHex,
  });

  final String id;
  final String name;
  final String iconPath;
  final int colorHex;

  factory TransactionsCategoriesModel.fromEntity({
    required TransactionCategoryEntity categoryEntity,
  }) {
    return TransactionsCategoriesModel(
      id: categoryEntity.id,
      name: categoryEntity.name,
      iconPath: categoryEntity.iconPath,
      colorHex: categoryEntity.colorHex,
    );
  }

  TransactionCategoryEntity toEntity() {
    return TransactionCategoryEntity(
      id: id,
      name: name,
      iconPath: iconPath,
      colorHex: colorHex,
    );
  }
}
