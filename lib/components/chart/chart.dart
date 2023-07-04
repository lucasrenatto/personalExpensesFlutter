import 'package:expanses/components/chart/chartBar.dart';
import 'package:expanses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  Chart({super.key, required this.recentTransaction});

  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;

        for (var i = 0; i < recentTransaction.length; i++) {
          bool sameDay = recentTransaction[i].Date.day == weekDay.day;
          bool sameMonth = recentTransaction[i].Date.month == weekDay.month;
          bool sameYear = recentTransaction[i].Date.year == weekDay.year;

          if (sameDay && sameMonth && sameYear) {
            totalSum += recentTransaction[i].Value;
          }
        }

        print(DateFormat.E().format(weekDay)[0]);
        print(totalSum);

        return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
      },
    ).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0, (sum, tr) {
      double val = double.tryParse(tr['value'].toString()) ?? 0.0;
      return sum + val;
    });
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
            children: groupedTransactions.map((tr) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: tr['day'].toString(),
                  percentage: _weekTotalValue == 0
                      ? 0
                      : (tr['value'] as double) / _weekTotalValue,
                  value: double.tryParse(tr['value'].toString()) ?? 0.0,
                ),
              );
            }).toList()),
      ),
    );
  }
}
