import 'package:bmi_calculator/constants/app_constants.dart';
import 'package:bmi_calculator/dbfunctions/bmidb.dart';
import 'package:bmi_calculator/models/bmi_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PreviousResults extends StatefulWidget {
  const PreviousResults({super.key});

  @override
  State<PreviousResults> createState() => _PreviousResultsState();
}

class _PreviousResultsState extends State<PreviousResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Previous Results',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: bmiNotifier,
        builder: (BuildContext ctx, List<BmiModel> bmiList, Widget? child) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = bmiList[index];

              return ListTile(
                  title: Row(
                children: [
                  Text(
                    data.height,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    data.weight,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(data.bmi, style: const TextStyle(color: Colors.black))
                ],
              ));
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: bmiList.length,
          );
        },
      ),
    );
  }
}
