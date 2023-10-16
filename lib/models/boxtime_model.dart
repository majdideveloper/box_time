import 'package:flutter/material.dart';

class BoxTimeModel {
  DateTime? from;
  DateTime? to;
  String goal;
  Color color;
  BoxTimeModel({
    this.from,
    this.to,
    required this.goal,
    required this.color,
  });
}
