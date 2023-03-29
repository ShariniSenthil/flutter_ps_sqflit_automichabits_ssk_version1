import 'package:flutter/material.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habit_service.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habits_by_frequency.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/journal_screen.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habits_screen.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _habitList = <Widget>[];
  HabitService _habitService = HabitService();

  @override
  initState() {
    super.initState();
    getAllFrequency();
  }

  getAllFrequency() async {
    var habitFrequency = await _habitService.readHabits();

    habitFrequency.forEach((habitFrequency) {
      setState(() {
        _habitList.add(InkWell(
          onTap: () {
            print('----------> Selected Frequency:');
            print(habitFrequency['name']);
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new HabitsByFrequency(habitFrequency: habitFrequency['name'],
                      )),
            );
          },
          child: ListTile(
            title: Text(habitFrequency['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xfffefcfe),
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(''),
              accountEmail: Text(''),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'images/bg.png',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.featured_play_list_outlined,
                color: Colors.deepPurple,
              ),
              title: Text(
                'Habits',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HabitsScreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.create,
                color: Colors.deepPurple,
              ),
              title: Text(
                'Journal',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => JournalScreen()));
              },
            ),
            Divider(),
            Column(
              children: _habitList,
            )
          ],
        ),
      ),
    );
  }
}
