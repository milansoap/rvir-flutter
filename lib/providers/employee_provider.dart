import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Map<String, dynamic>> employees = [];

  void addEmployee(Map<String, dynamic> newEmployee) {
    employees.add(newEmployee);
    notifyListeners();
  }
}
