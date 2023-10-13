import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/employee_provider.dart';

class EmployeesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    final employees = employeeProvider.employees;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees list'),
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.person, size: 75, color: Colors.blue),
                title: Text(employee["Name"]),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Job Role: ${employee["Job Role"]}'),
                    Text('Birth Date: ${employee["Birth Date"]}'),
                    Text('Arrrival Time: ${employee["Time In"]}'),
                    Text('Departure Time: ${employee["Time Out"]}')
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ));
        },
      ),
    );
  }
}
