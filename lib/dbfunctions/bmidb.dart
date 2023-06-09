import 'package:bmi_calculator/models/bmi_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<BmiModel>> bmiNotifier = ValueNotifier([]);

Future<void> addBmiData(BmiModel value) async {
  print(value);
  final bmiData = await Hive.openBox<BmiModel>('bmi_db');
  final _id = await bmiData.add(value);
  value.id = _id;
  print(_id);
  getBmiData();
  bmiNotifier.value.add(value);
  // bmiNotifier.notifyListeners();
}

Future<void> getBmiData() async {
  final bmiDB = await Hive.openBox<BmiModel>('bmi_db');
  final data = bmiDB.values.toList();
  bmiNotifier.value.clear();

  for (var i in data) {
    bmiNotifier.value.add(i);
    //bmiNotifier.notifyListeners();
  }
}

Future<void> deleteData(int id) async {
  final bmiData = await Hive.openBox<BmiModel>('bmi_db');
  bmiData.deleteAt(id);
  getBmiData();
}
