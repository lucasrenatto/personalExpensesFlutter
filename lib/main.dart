import 'dart:math';
import 'package:expanses/components/chart/chart.dart';
import 'package:expanses/components/transaction/transaction_form.dart';
import 'package:flutter/material.dart';
import 'components/transaction/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});
  final ThemeData tema = ThemeData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyHomePage(),
        theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      ID: 0,
      Title: "Conta Antiga",
      Value: 400.00,
      Date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      ID: 1,
      Title: "Novo Tênis de Corrida",
      Value: 450.00,
      Date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      ID: 2,
      Title: "Conta de Luz",
      Value: 130.00,
      Date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      ID: 2,
      Title: "Conta de Luz",
      Value: 130.00,
      Date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      ID: 2,
      Title: "Conta de Luz",
      Value: 130.00,
      Date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      ID: 2,
      Title: "Conta de Luz",
      Value: 130.00,
      Date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      ID: 2,
      Title: "Conta de Luz",
      Value: 130.00,
      Date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      ID: 2,
      Title: "Conta de Luz",
      Value: 130.00,
      Date: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.Date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      ID: Random().nextInt(9999),
      Title: title,
      Value: value,
      Date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  void _deleteTransaction(int ID) {
    setState(() {
      _transactions.removeWhere((element) => element.ID == ID);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext build) {
    final appBar = AppBar(
      title: const Text(
        'Despesas Pessoais',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
    );
    final availabelHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: availabelHeight * 0.3,
              child: Chart(recentTransaction: _recentTransactions),
            ),
            Container(
              height: availabelHeight * 0.7,
              child: TransactionList(
                transaction: _transactions,
                onRemove: _deleteTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
