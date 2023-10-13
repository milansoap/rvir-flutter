import 'package:flutter/material.dart';
import 'package:my_app/screens/employees.dart';
import 'package:my_app/screens/form.dart';
import 'package:my_app/screens/employees.dart';
import 'package:my_app/screens/form.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    FormScreen(),
    EmployeesScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Add your employee"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Employees"),
        ],
      ),
    );
  }
}
