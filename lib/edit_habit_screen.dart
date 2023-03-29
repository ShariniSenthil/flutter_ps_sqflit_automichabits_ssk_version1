import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habit.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habits_screen.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habit_service.dart';
import 'package:intl/intl.dart';

class EdithabitScreen extends StatefulWidget {
  const EdithabitScreen({Key? key}) : super(key: key);

  @override
  State<EdithabitScreen> createState() =>
      _EdithabitScreenState();
}

class _EdithabitScreenState extends State<EdithabitScreen> {
  var _habitController = TextEditingController();
  var _habitDateController = TextEditingController();

  String? _selectedValue;
  var _habitFrequency = ['Daily','Weekly','Monthy','Quarterly','Yearly'];

  var isFinished = 0;
  bool value = false;

  bool firstTimeFlag = false;
  int _selectedId = 0;

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
    if (firstTimeFlag == false) {
      print('---------->once execute ');
      firstTimeFlag = true;
      final todo = ModalRoute.of(context)!.settings.arguments as Habit;
      print('---------->Received Data:');

      print(todo.id);
      print(todo.habit);
      print(todo.habitFrequency);

      print(todo.habitDate);
      print(todo.isFinished);

      _selectedId = todo.id!;
      _habitController.text = todo.habit;

      _habitDateController.text = todo.habitDate;
      _selectedValue = todo.habitFrequency;

      if (todo.isFinished == 0) {
        value = false;
      } else {
        value = true;
      }
    }
    return Scaffold(
        backgroundColor: Color(0xfffefcfe),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Edit Habit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem(value: 1, child: Text("Delete")),
              ],
              elevation: 2,
              onSelected: (value) {
                if (value == 1) {
                  _deleteTodoRecord();
                }
              },
            ),
          ],
        ),
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
                        style: TextStyle(fontSize: 17.0),
                      ), //Text
                      SizedBox(width: 10), //SizedBox
                      Checkbox(
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
                      ), //Checkbox
                    ], //<Widget>[]
                  ),
            ),
              SizedBox(
                height: 50,
              ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),

                    onPressed: () async {

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HabitsScreen()));

                      print(_selectedId);
                      print(_habitController.text);
                      print(_selectedValue.toString());
                      print(_habitDateController.text);
                      print(isFinished);

                      var habitObject = Habit();

                      // edit only
                      habitObject.id = _selectedId;
                      habitObject.habit = _habitController.text;
                      habitObject.habitFrequency = _selectedValue.toString();
                      habitObject.habitDate = _habitDateController.text;
                      habitObject.isFinished = isFinished;

                      var _habitService = HabitService();

                      var result = await _habitService.updateHabit(habitObject);

                      print('Result: $result');

                      if(result >0 ){
                        _showSuccessSnackBar('Updated.');
                      }
                    },
                    child: Text('Update'),

                  )
            ])));
  }

  _showSuccessSnackBar(message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  _deleteTodoRecord() async {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => HabitsScreen()));
    var _habitService = HabitService();
    var result = await _habitService.deleteHabit(_selectedId);
    print('Result: $result');
    if (result > 0) {
      _showSuccessSnackBar('Deleted.');
    }
  }
}
