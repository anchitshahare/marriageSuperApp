import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class AddNewTask extends StatefulWidget {
  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController _tasknameController = TextEditingController();
  TextEditingController _taskdetailsController = TextEditingController();
  TextEditingController _datepickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final modalbottomsheetHeight = MediaQuery.of(context).size.height * 0.75;

    return Container(
      height: modalbottomsheetHeight,
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Add New Task',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: modalbottomsheetHeight * 0.05,
            ),
            TextField(
              controller: _tasknameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Task Name',
              ),
            ),
            SizedBox(
              height: modalbottomsheetHeight * 0.05,
            ),
            TextField(
              controller: _taskdetailsController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Task Details',
              ),
            ),
            SizedBox(
              height: modalbottomsheetHeight * 0.05,
            ),
            TextField(
              readOnly: true,
              controller: _datepickerController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Completion Date',
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2025),
                );
                if (pickedDate != null) {
                  setState(() {
                    _datepickerController.text =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                  });
                } else {
                  print('Date not selected');
                }
              },
            ),
            SizedBox(
              height: modalbottomsheetHeight * 0.05,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(
                    Task(
                      taskName: _tasknameController.text,
                      taskDetails: _taskdetailsController.text,
                      pickedDate: _datepickerController.text,
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