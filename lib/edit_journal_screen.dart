import 'package:flutter/material.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/journal.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/journal_screen.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/journal_service.dart';

import 'package:intl/intl.dart';

class EditJournalScreen extends StatefulWidget {
  const EditJournalScreen({Key? key}) : super(key: key);

  @override
  State<EditJournalScreen> createState() => _EditJournalScreenState();
}

class _EditJournalScreenState extends State<EditJournalScreen> {
  var _journalController = TextEditingController();
  var _journalDateController = TextEditingController();

  bool firstTimeFlag = false;
  int _selectedId = 0;

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
    if (firstTimeFlag == false) {
      print('---------->once execute ');
      firstTimeFlag = true;
      final journal = ModalRoute.of(context)!.settings.arguments as Journal;
      print('---------->Received Data:');

      print(journal.id);
      print(journal.journal);
      print(journal.journalDate);

      _selectedId = journal.id!;
      _journalController.text = journal.journal;
      _journalDateController.text = journal.journalDate;
    }
    return Scaffold(
      backgroundColor: Color(0xfffefcfe),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Journal',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xfffefcfe),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
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
            SizedBox(
              child: TextField(
                controller: _journalController,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    hintText: 'How did you feel today',
                    labelText: 'Journal',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
            ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () async {
                        var _journalService = JournalService();
                        var result =
                        await _journalService.deleteJournal(_selectedId);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => JournalScreen()));

                        print('Result: $result');
                      },
                      child: Text('Delete'),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () async {
                        var journalObject = Journal();

                        print(_selectedId);
                        print(_journalController.text);
                        print(_journalDateController.text);

                        // edit only
                        journalObject.id = _selectedId;
                        journalObject.journal = _journalController.text;
                        journalObject.journalDate = _journalDateController.text;

                        var _journalService = JournalService();

                        var result =
                            await _journalService.updateJournal(journalObject);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => JournalScreen()));

                        print('Result: $result');
                        if (result > 0) {}
                      },
                      child: Text('Update'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
