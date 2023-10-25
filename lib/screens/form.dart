import 'package:flutter/material.dart';
import 'package:my_app/boxes/boxes.dart';
import 'package:my_app/models/employee.dart';
import 'package:my_app/providers/employee_provider.dart';
import 'package:my_app/screens/employees.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeInController = TextEditingController();
  TextEditingController timeOutController = TextEditingController();

  String jobRole = "Engineer";
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTimeIn = TimeOfDay.now();
  TimeOfDay selectedTimeOut = TimeOfDay.now();
  String formattedDate = ""; // Add this line to store formatted date
  List<Map<String, dynamic>> employees = [];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    print(picked);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
  }

  Future<void> _selectTimeIn() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimeIn,
    );
    if (picked != null && picked != selectedTimeIn) {
      setState(() {
        selectedTimeIn = picked;
        timeInController.text =
            "${picked.hour}:${picked.minute.toString().padLeft(2, '0')}"; // Null check
      });
    }
  }

  Future<void> _selectTimeOut() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimeOut,
    );
    if (picked != null && picked != selectedTimeOut) {
      setState(() {
        selectedTimeOut = picked;
        timeOutController.text =
            "${picked.hour}:${picked.minute.toString().padLeft(2, '0')}"; // Null check
      });
    }
  }

  InputDecoration getDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add your employee')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: getDecoration('Ime'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: lastNameController,
              decoration: getDecoration('Priimek'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              value: jobRole,
              items: [
                DropdownMenuItem(child: Text("Engineer"), value: "Engineer"),
                DropdownMenuItem(child: Text("Manager"), value: "Manager"),
              ],
              onChanged: (value) {
                setState(() {
                  jobRole = value as String;
                });
              },
              decoration: getDecoration('Delovno mesto'),
            ),
            SizedBox(height: 16),

            TextFormField(
              controller: dateController,
              onTap: _selectDate,
              readOnly: true,
              decoration: getDecoration('Datum rojstva'),
            ),

            SizedBox(height: 16.0),
            TextFormField(
              controller: timeInController,
              onTap: _selectTimeIn,
              readOnly: true,
              decoration: getDecoration('Ura prihoda'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: timeOutController,
              onTap: _selectTimeOut,
              readOnly: true,
              decoration: getDecoration('Ura odhoda'),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> newEmployee = {
                    "Name": nameController.text,
                    "Last Name": lastNameController.text,
                    "Job Role": jobRole,
                    "Birth Date": dateController.text,
                    "Time In": timeInController.text,
                    "Time Out": timeOutController.text,
                  };

                  setState(() {
                  //  Provider.of<EmployeeProvider>(context, listen: false).addEmployee(newEmployee);

                  //   // Clear form fields
                  //   nameController.clear();
                  //   lastNameController.clear();
                  //   dateController.clear();
                  //   timeInController.clear();
                  //   timeOutController.clear();
                  //   jobRole = "Engineer";

                    String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
                    Employee newEmp = Employee(
                        firstName: nameController.text,
                        lastName: lastNameController.text,
                        jobPosition: jobRole,
                        workplace: 'Workplace_here', // Fill appropriately
                        birthDate: selectedDate,
                        arrivalTime: timeInController.text,
                        departureTime: timeOutController.text,
                        id:'id');
                        boxEmployees.put(uniqueId, newEmp);
                  
                  });
                },
                child: Text("Add Employee"),
              ),
            ),

            // Date and Time pickers remain the same
          ],
        ),
      ),
    );
  }
}
