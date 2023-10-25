import 'package:flutter/material.dart';
import 'package:my_app/models/employee.dart';
import 'package:my_app/providers/employee_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/screens/home.dart';

import 'boxes/boxes.dart';


void main() async {
  
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  boxEmployees = await Hive.openBox<Employee>('employeeBox');



  runApp(
    ChangeNotifierProvider(
      create: (context) => EmployeeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
