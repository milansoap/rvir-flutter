import 'package:flutter/material.dart';
import 'package:my_app/boxes/boxes.dart';
import 'package:provider/provider.dart';
import '../providers/employee_provider.dart';
import 'package:hive/hive.dart';
import '../models/employee.dart';

class EmployeesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Employees list'),
        ),
        body: FutureBuilder(
          future: Hive.openBox<Employee>('employeeBox'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              var box = Hive.box<Employee>('employeeBox');
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final employee = box.getAt(index);
                  if (employee != null) {
                    return Card(
                      margin: EdgeInsets.all(10),
                      elevation: 5,
                      child: ListTile(
                        leading:
                            Icon(Icons.person, size: 50, color: Colors.blue),
                        title:
                            Text('${employee.firstName} ${employee.lastName}'),
                        subtitle: Text('Job Role: ${employee.jobPosition}'),
                        onTap: () =>
                            _showEmployeeDialog(context, employee, index),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}

void _showEmployeeDialog(BuildContext context, Employee employee, int index) {
  var box = Hive.box<Employee>('employeeBox');

  TextEditingController nameController      = TextEditingController(text: employee.firstName);
  TextEditingController lastNameController  = TextEditingController(text: employee.lastName);
  TextEditingController jobPositionController  = TextEditingController(text: employee.jobPosition);

  

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit Employee'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: jobPositionController,
                decoration: InputDecoration(labelText: 'Job Role'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Save'),
            onPressed: () {
              // Since you cannot assign new values to final fields,
              // create a new Employee instance with the updated and existing values.
              Employee updatedEmployee = Employee(
                id: employee.id, // Keep the same id
                firstName: nameController.text,
                lastName: lastNameController.text,
                jobPosition: jobPositionController.text, // Keep the existing jobPosition
                workplace: employee.workplace, // Keep the existing workplace
                birthDate: employee.birthDate, // Keep the existing birthDate
                arrivalTime:
                    employee.arrivalTime, // Keep the existing arrivalTime
                departureTime:
                    employee.departureTime, // Keep the existing departureTime
                // ... other fields ...
              );

              // Save the updated employee object to Hive
              box.putAt(index, updatedEmployee);

              // Close the dialog
              Navigator.of(context).pop();

              // Optionally show a confirmation message
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              // Delete the employee from the Hive box
              box.deleteAt(index);
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
