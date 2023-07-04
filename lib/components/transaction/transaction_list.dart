import 'package:expanses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(int) onRemove;

  TransactionList({super.key, required this.transaction, required this.onRemove});
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Column(
            children: [
              Text("Vazio"),
              Image.network(
                  "https://ouch-cdn2.icons8.com/HRzD_ptpkHwwXXFQpXuwW71g0uWOn_RlaFcjtvUEBmo/rs:fit:256:256/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNzAy/L2NhMzdiOWMzLWQz/Y2MtNDRiYy04NmM1/LTM1Y2IwMWE1MjUx/NC5zdmc.png")
            ],
          )
        : ListView.builder(
            itemCount: this.transaction.length,
            itemBuilder: (ctx, index) {
              final tr = transaction[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          'R\$${tr.Value}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    radius: 30,
                  ),
                  title: Text(
                    tr.Title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.Date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => {onRemove(tr.ID)},
                  ),
                ),
              );
            },
          );
  }
}
