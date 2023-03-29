import 'package:flutter/material.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/addjournal_screen.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/drawer_navigation.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/edit_journal_screen.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/journal_service.dart';


import 'journal.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  late JournalService _journalService;
  late List<Journal> _journalList;

  @override
  void initState() {
    super.initState();
    getAllJournals();
  }

  getAllJournals() async {
    _journalService = JournalService();
    _journalList = <Journal>[];

    var journals = await _journalService.readJournal();

    journals.forEach((todo) {
      setState(() {
        var journalModel = Journal();

        journalModel.id = todo['id'];
        journalModel.journal = todo['journal'];
        journalModel.journalDate = todo['journalDate'];

        _journalList.add(journalModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffefcfe),
        drawer: DrawerNavigation(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Journal',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Color(0xfffefcfe),
          elevation: 0,
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(
                  Icons.menu_sharp,
                  color: Colors.black87,
                  size: 30,
                ));
          }),
        ),
      body: ListView.builder(
          itemCount: _journalList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    print('---------->Edit or Delete invoked: Send Data');
                    print(_journalList[index].id);
                    print(_journalList[index].journal);
                    print(_journalList[index].journalDate);

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditJournalScreen(),
                      settings: RouteSettings(
                        arguments: _journalList[index],
                      ),
                    ));
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_journalList[index].journal ?? 'No Journal'),
                    ],
                  ),
                  trailing: Text(
                      _journalList[index].journalDate ?? 'No Journal Date'),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddJournalScreen()));
        },
      ),
    );
  }
}
