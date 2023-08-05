import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

import 'form.dart';

class Cal extends StatelessWidget {
  final String age;
  final String weight;
  final String height;
  final String gender;
  final String bmi;
  late String status;

  Cal({
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    required this.bmi,
  });

  @override
  Widget build(BuildContext context) {
    double inBmi = double.parse(bmi);
    String outBmi = inBmi.toStringAsFixed(2);

    ;

    Color _text = Colors.black;
    //Color _back = Colors.black;

    if (double.parse(bmi) <= 18.4) {
      //_back = Colors.amber;
      outBmi = '$outBmi😑';
      status = 'Underweight';
      _text = Colors.amber;
    } else if (double.parse(bmi) >= 18.5 && double.parse(bmi) <= 24.9) {
      //_back = Colors.green;
      outBmi = '$outBmi😄';
      status = 'Normal';
      _text = Colors.green;
    } else if (double.parse(bmi) >= 25 && double.parse(bmi) <= 39.9) {
      //_back = Colors.orange;
      outBmi = '$outBmi🙄';
      status = 'Overweight';
      _text = Colors.orange;
    } else {
      //_back = Colors.deepOrange;
      outBmi = '$outBmi😵';
      status = 'Obese';
      _text = Colors.deepOrange;
    }
    // Build your Cal screen UI using the provided age, weight, and height values
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text('Cal Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 111,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  margin: const EdgeInsets.only(right: 20, left: 10, top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Text(
                    'Age: $age',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                    width: 120.0,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    margin: const EdgeInsets.only(right: 20, top: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(
                      'Weight:$weight KG',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                    //color: Colors.blueAccent,
                    ),
                Container(
                    width: 120.0,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    margin: const EdgeInsets.only(right: 10, top: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(
                      'Height:$height Cm',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                    //color: Colors.blueAccent,
                    ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              width: double.infinity,
              height: 50,

              ///color: Colors.amberAccent,
              child: Text(
                'Your Result',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              width: double.infinity,
              height: 50,
              //color: Colors.amberAccent,
              child: Text(
                '$status',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _text,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  //color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              width: double.infinity,
              height: 300,
              //color: Colors.amberAccent,
              padding: EdgeInsets.only(top: 0.0),
              child: Text(
                '$outBmi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _text,
                  fontSize: 130,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 6, 55, 113)),
                child: Text('ReCalculate BMI'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
