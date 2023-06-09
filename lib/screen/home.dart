import 'package:bmi_calculator/constants/app_constants.dart';
import 'package:bmi_calculator/dbfunctions/bmidb.dart';
import 'package:bmi_calculator/models/bmi_model.dart';
import 'package:bmi_calculator/screen/previous_results.dart';

import 'package:bmi_calculator/widgets/letf_bar.dart';
import 'package:bmi_calculator/widgets/right_bar.dart';
import 'package:flutter/material.dart';

class BmiHomeScreen extends StatefulWidget {
  const BmiHomeScreen({super.key});

  @override
  State<BmiHomeScreen> createState() => _BmiHomeScreenState();
}

class _BmiHomeScreenState extends State<BmiHomeScreen> {
  TextEditingController _heightController = TextEditingController();

  TextEditingController _weightController = TextEditingController();

  double _bmiResult = 0;

  String _textResult = "";

  bool _redSignal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: TextStyle(
            color: accentHexColor,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: mainHexColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 130,
                  child: TextField(
                    controller: _heightController,
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                      color: accentHexColor,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Height",
                      hintStyle: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 130,
                  child: TextField(
                    controller: _weightController,
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                      color: accentHexColor,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Weight",
                      hintStyle: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              child: InkWell(
                onTap: () {
                  double _h = double.parse(_heightController.text);
                  double _w = double.parse(_weightController.text);
                  print('Hello');
                  setState(() {
                    _bmiResult = (_w / _h / _h) * 10000;

                    String inString = _bmiResult.toStringAsFixed(1);

                    _bmiResult = double.parse(inString);

                    if (_bmiResult > 25) {
                      _textResult = "You are Overweight";
                      _redSignal = true;
                    } else if (_bmiResult >= 18.5 && _bmiResult < 25) {
                      _textResult = "You Are Healthy";
                      _redSignal = false;
                    } else {
                      _textResult = "You Are Underweight";
                      _redSignal = true;
                    }
                  });
                  addData(context, _bmiResult);
                },
                child: Text(
                  'Calculate',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: accentHexColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              child: Text(
                _bmiResult.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 90,
                    color: (_redSignal ? Colors.red : Colors.green.shade600)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              child: Visibility(
                visible: _textResult.isNotEmpty,
                child: Text(
                  _textResult,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: (_redSignal ? Colors.red : Colors.green.shade600)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const LeftBar(barwidth: 40),
            const SizedBox(
              height: 10,
            ),
            const LeftBar(barwidth: 60),
            const SizedBox(
              height: 10,
            ),
            const LeftBar(barwidth: 40),
            const SizedBox(
              height: 40,
            ),
            const RightBAr(barwidth: 40),
            const SizedBox(
              height: 10,
            ),
            const RightBAr(barwidth: 60),
            const SizedBox(
              height: 10,
            ),
            const RightBAr(barwidth: 40),
            InkWell(
              onTap: () {
                _heightController.text = "";
                _weightController.text = "";

                setState(() {
                  _bmiResult = 0;
                  _textResult = "";
                });

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PreviousResults()));
              },
              child: Text(
                "View Previous Results",
                style: TextStyle(
                    color: Colors.yellow.shade500,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addData(BuildContext context, double bmiResult) async {
    print("add data");
    final _height = _heightController.text.trim();
    final _weight = _weightController.text.trim();
    String bmiToAdd = bmiResult.toString();

    if (_height.isNotEmpty && _weight.isNotEmpty) {
      final _bmi = BmiModel(bmi: bmiToAdd, weight: _weight, height: _height);

      print(_bmi);

      addBmiData(_bmi);
    }
  }
}
