import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transaction.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No Transaction Added Yet!',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.60,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, idx) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            '\$${transaction[idx].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '${transaction[idx].title}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                        '${DateFormat.yMMMd().format(transaction[idx].date)}'),
                    trailing: IconButton(
                      onPressed: () {
                        deleteTx(transaction[idx].id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
