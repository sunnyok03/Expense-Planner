import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValue {
    return List.generate(7, (index) {
      //check the current day
      final weekDay = DateTime.now().subtract(Duration(days: index));
      //total amount spent on the given weekday
      double totalSum = 0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      //return map for all the last 7 days as a list
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalWeekSpending {
    return groupedTransactionsValue.fold(
        0.0, (sum, item) => (sum + (item['amount'] as double)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: (data['day'] as String),
                  spending: (data['amount'] as double),
                  spendingPercentage: totalWeekSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalWeekSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
