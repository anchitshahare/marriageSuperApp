import 'package:flutter/material.dart';
import '../models/expenses.dart';

final List<String> _expenseCategory = ['Jewellery', 'Clothes'];

class AddNewExpense extends StatefulWidget {
  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  String? _dropdownValue;
  TextEditingController _budgetamountController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final modalbottomsheetHeight =
        MediaQuery.of(context).copyWith().size.height * 0.75;

    return Container(
      height: modalbottomsheetHeight,
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Add New Expense',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: modalbottomsheetHeight * 0.05,
            ),
            DropdownButton(
              hint: const Text('Expense Category'),
              isExpanded: true,
              value: _dropdownValue,
              items: _expenseCategory.map((dropdowntext) {
                return DropdownMenuItem(
                    value: dropdowntext, child: Text(dropdowntext));
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _dropdownValue = value;
                });
              },
            ),
            SizedBox(
              height: modalbottomsheetHeight * 0.05,
            ),
            TextField(
              controller: _budgetamountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Budget Amount',
              ),
            ),
            SizedBox(
              height: modalbottomsheetHeight * 0.05,
            ),
            TextField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Notes',
              ),
            ),
            SizedBox(
              height: modalbottomsheetHeight * 0.05,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(
                    Expenses(
                      category: _dropdownValue,
                      amount: double.parse(_budgetamountController.text),
                      notes: _notesController.text,
                    ),
                  );
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
