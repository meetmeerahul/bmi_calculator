import 'package:hive_flutter/hive_flutter.dart';

part 'bmi_model.g.dart';

@HiveType(typeId: 1)
class BmiModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String weight;

  @HiveField(2)
  final String height;

  @HiveField(3)
  final String bmi;

  BmiModel(
      {required this.weight, required this.height, required this.bmi, this.id});
}
