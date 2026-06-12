import 'package:flutter/material.dart';

class MonthlySpendCard extends StatelessWidget {
  const MonthlySpendCard({
    super.key,
    required this.currentMonthSpend,
    required this.percentageChange,
  });

  final double currentMonthSpend;
  final double percentageChange;

  @override
  Widget build(BuildContext context) {
    final isPositive = percentageChange >= 0;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Monthly Spend',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Spacer(),
              Icon(Icons.analytics_outlined, color: Colors.white),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            '₹${currentMonthSpend.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: Colors.white,
                size: 16,
              ),

              const SizedBox(width: 4),

              Text(
                '${percentageChange.abs().toStringAsFixed(1)}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 6),

              const Text(
                'vs last month',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
