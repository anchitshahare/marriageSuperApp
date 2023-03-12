import 'package:flutter/material.dart';
import 'package:marriage_super_app/Checklist/models/task.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../widgets/add_new_task.dart';

class ChecklistScreen extends StatefulWidget {
  static const routName = '/checklist';

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  String? _dropdownValue;
  List<Task> _tasks = [];

  Future<dynamic> _addNewTask(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return AddNewTask();
      },
    ).then((newTask) {
      if (newTask != null) {
        setState(() {
          _tasks.add(newTask);
        });
      } else {
        print('Task added is null');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    int totalTasks = _tasks.length;
    int completedTasks = 0;

    for (var task in _tasks) {
      if (task.status == true) completedTasks++;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist'),
        actions: [
          IconButton(
            onPressed: () => _addNewTask(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.2,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (_tasks.isEmpty && totalTasks != completedTasks)
                  Text('Start adding tasks'),
                if (_tasks.isNotEmpty && totalTasks != completedTasks)
                  Text('$completedTasks / $totalTasks tasks completed'),
                if (totalTasks == completedTasks) Text('You are up to date!'),
                CircularPercentIndicator(
                  radius: 60,
                  lineWidth: 15,
                  percent: _tasks.isEmpty ? 0 : completedTasks / totalTasks,
                  center: _tasks.isEmpty
                      ? Text('0')
                      : Text('${completedTasks / totalTasks * 100}%'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: width * 0.5,
            child: const Divider(
              color: Colors.black,
            ),
          ),
          if (_tasks.isNotEmpty)
            Container(
              alignment: Alignment.centerRight,
              child: DropdownButton(
                value: _dropdownValue,
                items: [
                  DropdownMenuItem(
                    child: Text('Today'),
                    value: 'Today',
                  ),
                  DropdownMenuItem(
                    child: Text('Upcoming'),
                    value: 'Upcoming',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _dropdownValue = value;
                  });
                },
              ),
            ),
          if (_tasks.isEmpty)
            const Center(
              child: Text('No tasks added'),
            ),
          if (_tasks.isNotEmpty)
            Expanded(
              child: ListView.separated(
                itemCount: _tasks.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                  indent: width * 0.12,
                ),
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(_tasks[index].taskName),
                    background: Container(
                      color: Colors.red[600],
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        _tasks.removeAt(index);
                      });
                    },
                    child: Row(
                      children: [
                        Checkbox(
                            value: _tasks[index].status,
                            onChanged: (value) {
                              setState(() {
                                _tasks[index].status = value;
                              });
                            }),
                        if (_tasks[index].status == false)
                          Text(_tasks[index].taskName!),
                        if (_tasks[index].status == true)
                          Text(
                            _tasks[index].taskName!,
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
