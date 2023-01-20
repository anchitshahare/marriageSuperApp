import 'package:flutter/material.dart';

class Expenses {
  String? category;
  double amount;
  String? notes;
  double actualSpend = 0;

  Expenses({
    required this.category,
    required this.amount,
    required this.notes,
    this.actualSpend = 0,
  });
}
