import 'package:flutter/material.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/journal.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/journal_screen.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/journal_service.dart';

import 'package:intl/intl.dart';

class AddJournalScreen extends StatefulWidget {
  const AddJournalScreen({Key? key}) : super(key: key);

  @override
  State<AddJournalScreen> createState() => _AddJournalScreenState();
}

class _AddJournalScreenState extends State<AddJournalScreen> {
  var _journalController = TextEditingController();
  var _journalDateController = TextEditingController();

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
        _journalDateController.text =
            DateFormat('dd-MM-yyyy').format(_pickedDate);
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
            'Add Journal',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Color(0xfffefcfe),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _journalDateController,
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
              Divider(),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: _journalController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius:
                            BorderRadius.circular(5.5)), // OutlineInputBorder
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.5)),
                    hintText: 'How did you feel today?',
                    labelText: 'Journal',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold)),
                maxLines: 10,
              ),
              SizedBox(
                height: 20,
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
                  var journalObject = Journal();

                  journalObject.journal = _journalController.text;
                  journalObject.journalDate = _journalDateController.text;

                  var _journalService = JournalService();

                  var result = await _journalService.saveJournal(journalObject);

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => JournalScreen()));

                  print('Result: $result');
                  if (result > 0) {}
                },
                child: Text('Save'),
              ),
            ])));
  }
}
