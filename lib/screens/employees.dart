import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/employee_provider.dart';
import 'package:hive/hive.dart';
import '../models/employee.dart';

class EmployeesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    final employees = employeeProvider.employees;

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
                            Icon(Icons.person, size: 75, color: Colors.blue),
                        title:
                            Text('${employee.firstName} ${employee.lastName}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Job Role: ${employee.jobPosition}'),
                            Text('Birth Date: ${employee.birthDate}'),
                            Text(
                                'Arrival Time: ${employee.arrivalTime}'),
                            Text(
                                'Departure Time: ${employee.departureTime}'),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
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
