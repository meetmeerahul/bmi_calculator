import 'package:bmi_calculator/dbfunctions/bmidb.dart';
import 'package:bmi_calculator/models/bmi_model.dart';

import 'package:flutter/material.dart';

class PreviousResults extends StatefulWidget {
  const PreviousResults({super.key});

  @override
  State<PreviousResults> createState() => _PreviousResultsState();
}

class _PreviousResultsState extends State<PreviousResults> {
  @override
  Widget build(BuildContext context) {
    getBmiData();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Previous Results',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: const Color.fromARGB(96, 44, 44, 44),
        elevation: 0,
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: bmiNotifier,
        builder: (BuildContext ctx, List<BmiModel> bmiList, Widget? child) {
          if (bmiList.length == 0) {
            return const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Center(
                child: Text(
                  'No Previous Results Available',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
              ),
            );
          } else {
            return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = bmiList[index];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Height- ${data.height} CM",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Weight-${data.weight} KG",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "BMI - ${data.bmi} ",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => deleteResult(context, index),
                        child: const Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.white,
                  child: const Divider(),
                );
              },
              itemCount: bmiList.length,
            );
          }
        },
      ),
      backgroundColor: const Color.fromARGB(96, 44, 44, 44),
    );
  }

  deleteResult(BuildContext context, index) {
    showDialog(
      context: context,
      builder: ((ctx) => AlertDialog(
            content: const Text('really want to delete '),
            actions: [
              TextButton(
                onPressed: () {
                  deleteData(index);

                  Navigator.of(context).pop(ctx);
                  setState(() {
                    getBmiData();
                  });
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(ctx),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          )),
    );
  }
}
