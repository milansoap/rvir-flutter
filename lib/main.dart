import 'package:flutter/material.dart';
import 'package:my_app/providers/employee_provider.dart';
import 'package:provider/provider.dart';

import 'package:my_app/screens/home.dart';

void main() {
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
