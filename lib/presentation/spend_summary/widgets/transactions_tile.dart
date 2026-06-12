import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spending_summary/domain/entity/transaction_entity.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionTypeEntity.income;
    final currencySymbol = "\$";
    ValueNotifier<bool> showDelete = ValueNotifier<bool>(false);
    return ValueListenableBuilder(
      valueListenable: showDelete,
      builder: (context, value, child) {
        return AnimatedSize(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300),
          child: GestureDetector(
            onTap: () => showDelete.value = false,
            onLongPress: () => showDelete.value = true,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: transaction.category != null
                        ? Color(transaction.category!.colorHex)
                        : Colors.grey.shade400,
                    child: Text(
                      transaction.category?.name.substring(0, 1) ?? '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),

                  title: transaction.note.isNotEmpty
                      ? Text(
                          transaction.note,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        )
                      : Text(
                          transaction.category?.name ?? 'No Category',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),

                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (transaction.note.isNotEmpty) ...[
                        Text(
                          transaction.category?.name ?? 'No Category',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            // fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(width: 4),
                        Icon(Icons.circle, size: 8, color: Colors.grey),
                        const SizedBox(width: 4),
                      ],

                      Text(
                        _formatDate(transaction.timeStamp),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade800,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${isIncome ? '+' : '-'} $currencySymbol ${format.format(transaction.amount)}',
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: isIncome ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      // const SizedBox(height: 4),
                      // Text(
                      //   transaction.account.name,
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey.shade800,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                if (showDelete.value) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Delete Transaction',
                            style: TextStyle(fontSize: 16, letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

final format = NumberFormat('#,##,##,##0.00');
