import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee {
  @HiveField(0)
  final String firstName;
  @HiveField(1)
  final String lastName;
  @HiveField(2)
  final String jobPosition;
  @HiveField(3)
  final String workplace;
  @HiveField(4)
  final DateTime birthDate;
  @HiveField(5)
  final String arrivalTime;
  @HiveField(6)
  final String departureTime;
  @HiveField(7)
  final String id;

  Employee({
    required this.firstName,
    required this.lastName,
    required this.jobPosition,
    required this.workplace,
    required this.birthDate,
    required this.arrivalTime,
    required this.departureTime,
    required this.id
  });
}
