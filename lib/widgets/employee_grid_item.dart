import 'package:flutter/material.dart';
import 'package:my_app/models/employee.dart';

class EmployeeGridItem extends StatelessWidget {
    
    const EmployeeGridItem({Key? key, required this.employee}) : super(key: key);
    final Employee employee;

    @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
          Color.fromARGB(128, 0, 128, 255),
          Color.fromARGB(200, 255, 0, 128),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      ),
      child: Text(employee.firstName),
      );
  }

}