import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'cal.dart';

class form extends StatefulWidget {
  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  final _formKey = GlobalKey<FormState>();
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _name;
  late String _address;
  String _gender = '';
  late String _age;
  late String _weight;
  late String _height;
  double _meterHeight = 0;
  double _bmi = 0;
  double _meterSqu = 0;
  late TextEditingController dateInput = TextEditingController();
  TextEditingController addressInput = TextEditingController();
  TextEditingController weightInput = TextEditingController();
  TextEditingController nameInput = TextEditingController();
  TextEditingController heightInput = TextEditingController();

  void initState() {
    dateInput.text = '';
    _age = '';
    super.initState();
  }

  void _navigateToCalScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Cal(
          age: _age,
          weight: _weight,
          height: _height,
          gender: _gender,
          bmi: _bmi.toString(),
        ),
      ),
    );
  }

  String calculateAge(DateTime selectedDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - selectedDate.year;

    if (currentDate.month < selectedDate.month ||
        (currentDate.month == selectedDate.month &&
            currentDate.day < selectedDate.day)) {
      age--;
    }

    return age.toString();
  }

  void _clearForm() {
    setState(() {
      nameInput.clear();
      addressInput.clear();
      dateInput.clear();
      weightInput.clear();
      heightInput.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 164, 207, 218),
      appBar: AppBar(
        title: Text('BMI'),
        backgroundColor: Color.fromRGBO(11, 118, 190, 1),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            margin: EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextFormField(
                  controller: nameInput,
                  maxLength: 20,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      //hintText: 'Name',
                      labelText: "Enter Name"),
                  // validator: (text) {
                  //   if (text!.isEmpty) {
                  //     return 'Name cannot be empty';
                  //   }
                  //   return null;
                  // },
                  onSaved: (text) {
                    _name = text!;
                  },
                ),
                TextFormField(
                  controller: addressInput,
                  maxLength: 50,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Enter Address"),
                  // validator: (text) {
                  //   if (text!.isEmpty) {
                  //     return 'Address cannot be empty';
                  //   }
                  //   return null;
                  // },
                  onSaved: (text) {
                    _address = text!;
                  },
                  onChanged: (value) {
                    setState(() {
                      _address = value;
                    });
                  },
                ),

                // Label for gender
                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Radio buttons for gender
                Column(
                  children: [
                    ListTile(
                      title: Text('Male'),
                      leading: Radio(
                        value: 'Male',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value as String;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Female'),
                      leading: Radio(
                        value: 'Female',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value as String;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                TextField(
                  controller: dateInput,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.calendar_today),
                    labelText: "Enter Date",
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        dateInput.text = formattedDate;
                        _age = calculateAge(pickedDate);
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          validator: (text) {
                            if (text!.isEmpty) {
                              return 'Weight cannot be empty';
                            }
                            return null;
                          },
                          controller: weightInput,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Weight (Kg)',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _weight = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          //border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                            controller: heightInput,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Height cannot be empty';
                              }
                              if (double.tryParse(value) == null) {
                                return "Invalid Height value";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            textAlign:
                                TextAlign.center, // Align text to the center
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              //hintText: 'Height (CM)',
                              labelText: 'Height (Cm)',
                              // Adjust vertical padding
                            ),
                            onChanged: (value) {
                              setState(() {
                                _height = value;
                                _meterHeight = double.parse(_height) / 100;
                                _meterSqu = _meterHeight * _meterHeight;
                              });
                            }),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  width: 250,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text(
                    'Age: $_age',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.redAccent),
                      child: Text('Cal BMI'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _bmi = double.parse(_weight) / _meterSqu;
                          if (_bmi < 15) {
                            color:
                            Colors.amber;
                          }
                          _navigateToCalScreen();
                        }
                      },
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.blueAccent),
                      child: Text('Clear Form'),
                      onPressed: () {
                        _clearForm();
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
