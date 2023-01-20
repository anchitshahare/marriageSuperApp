import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../models/expenses.dart';
import '../widgets/add_new_expense.dart';
import '../widgets/update_expense.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  static const routeName = '/expense-tracker';

  const ExpenseTrackerScreen({super.key});

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  var sliderValue = 0.0;
  List<Expenses> _expenses = [];

  Future<dynamic> _addNewExpense(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return AddNewExpense();
      },
      isScrollControlled: true,
    ).then((value) {
      if (value != null) {
        setState(() {
          _expenses.add(value);
        });
      } else
        print('Value is NULL');
    });
  }

  Future<dynamic> _updateExpense(String? expenseCategory, double expenseAmount,
      String? notes, double actualSpend, int index, BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return UpdateExpense(
          expenseCategory: expenseCategory,
          expenseAmount: expenseAmount,
          notes: notes,
          actualSpend: actualSpend,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _expenses[index].category = value.category;
          _expenses[index].amount = value.amount;
          _expenses[index].notes = value.notes;
          _expenses[index].actualSpend = value.actualSpend;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double totalExpense = 0.0;
    double totalSpend = 0.0;

    for (var element in _expenses) {
      totalExpense += element.amount;
    }
    for (var element in _expenses) {
      totalSpend += element.actualSpend;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: () {
              _addNewExpense(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: 150,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: Text(
                        'Expected Budget \n Rs. $totalExpense',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.15,
                  child: VerticalDivider(
                    color: Colors.black,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: Text(
                        'Actual Spent \n Rs. $totalSpend',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          if (_expenses.isNotEmpty)
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _updateExpense(
                          _expenses[index].category,
                          _expenses[index].amount,
                          _expenses[index].notes,
                          _expenses[index].actualSpend,
                          index,
                          context);
                    },
                    child: ExpenseCard(
                      amount: _expenses[index].amount,
                      category: _expenses[index].category,
                      actualSpend: _expenses[index].actualSpend,
                    ),
                  );
                },
                itemCount: _expenses.length,
              ),
            ),
          if (_expenses.isEmpty)
            Center(
              child: Text('No Expenses Added!'),
            )
        ],
      ),
    );
  }
}

class ExpenseCard extends StatefulWidget {
  String? category;
  double amount;
  double actualSpend;

  ExpenseCard(
      {required this.category,
      required this.amount,
      required this.actualSpend});

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  var sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Card(
      // height: height * 0.1,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.all(height * 0.01),
        leading: Text(widget.category!),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Rs. ${widget.amount}'),
            SizedBox(
              width: 100,
              child: LinearPercentIndicator(
                percent: widget.actualSpend / widget.amount,
                lineHeight: 20,
                center: Text(
                  '${widget.actualSpend / widget.amount * 100} %',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                progressColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            // Text('Rs. ${widget.actualSpend}'),
          ],
        ),
      ),
    );
  }
}
