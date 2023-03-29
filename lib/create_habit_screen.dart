import 'package:flutter/material.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/drawer_navigation.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habit.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habits_screen.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habit_service.dart';
import 'package:intl/intl.dart';

class CreateToDoListScreen extends StatefulWidget {
  const CreateToDoListScreen({Key? key}) : super(key: key);

  @override
  State<CreateToDoListScreen> createState() => _CreateToDoListScreenState();
}

class _CreateToDoListScreenState extends State<CreateToDoListScreen> {
  var _habitController = TextEditingController();
  var _habitDateController = TextEditingController();

  String? _selectedValue;
  var _habitFrequency = ['Daily','Weekly','Monthy','Quarterly','Yearly'];

  var isFinished = 0;
  bool value = false;

  @override
  void initState() {
    super.initState();
  }

  DateTime _dateTime = DateTime.now();

  _selectedToDoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _habitDateController.text = DateFormat('dd-MM-yyyy').format(_pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffefcfe),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create  Habit',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xfffefcfe),
        elevation: 0,
      ),
      drawer: DrawerNavigation(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _habitController,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  labelText: 'Habit',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold)
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
              ),
              child: DropdownButtonFormField(
                dropdownColor: Colors.deepPurple.shade50,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius:
                          BorderRadius.circular(5.5)), // OutlineInputBorder
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                ),
                value: _selectedValue,
                items: _habitFrequency.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text('Habit Frequency',
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold)),
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.black87,
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value as String;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:30),
              child: TextFormField(
                controller: _habitDateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold),
                  hintText: 'Pick a date',
                  hintStyle: TextStyle(color: Colors.black54),
                  fillColor: Colors.deepPurple[100],
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectedToDoDate(context);
                    },
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.deepPurple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius:
                      BorderRadius.circular(5.5)), // OutlineInputBorder
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:30),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ), //SizedBox
                  Text(
                    'Task Status: ',
                    style: TextStyle(fontSize: 20.0),
                  ), //Text
                  SizedBox(width: 10), //SizedBox
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      fillColor:  MaterialStateProperty.all(Colors.deepPurple),
                      value: this.value,
                      onChanged: (value) {
                        setState(() {
                          this.value = value!;
                          if(value == true) {
                            isFinished = 1;
                          }else{
                            isFinished = 0;
                          }
                          print('-------------> check box value: $value');
                          print('-------------> isFinished Flag: $isFinished');
                        });
                      },
                    ),
                  ), //Checkbox
                ], //<Widget>[]
              ),
            ),
            SizedBox(
              height: 80,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () async {

                var habitObject = Habit();

                habitObject.habit = _habitController.text;
                habitObject.habitFrequency = _selectedValue.toString();
                habitObject.habitDate = _habitDateController.text;
                habitObject.isFinished = isFinished;

                var _habitService = HabitService();

                var result = await _habitService.saveHabit(habitObject);

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HabitsScreen()));

                print('Result: $result');
                if (result > 0) {
                  _showSuccessSnackBar('Created.');
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  _showSuccessSnackBar(message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }
}
