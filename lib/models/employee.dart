import 'package:flutter/material.dart';

class Employee {
  String firstName;
  String lastName;
  String jobPosition;
  String workplace;
  DateTime birthDate;
  TimeOfDay arrivalTime;
  TimeOfDay departureTime;

  Employee({
    required this.firstName,
    required this.lastName,
    required this.jobPosition,
    required this.workplace,
    required this.birthDate,
    required this.arrivalTime,
    required this.departureTime,
  });
}
