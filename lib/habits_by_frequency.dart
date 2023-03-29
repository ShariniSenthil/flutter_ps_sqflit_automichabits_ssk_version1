import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/drawer_navigation.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habit.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habit_service.dart';


class HabitsByFrequency extends StatefulWidget {

  String habitFrequency;

  HabitsByFrequency({Key? key, required this.habitFrequency}) : super(key: key);

  @override
  State<HabitsByFrequency> createState() => _HabitsByFrequencyState();
}

class _HabitsByFrequencyState extends State<HabitsByFrequency> {

  List<Habit> _habitList = <Habit>[];
  HabitService _habitService = HabitService();

  @override
  initState() {
    super.initState();
    getHabitsByFrequencies();
  }

  getHabitsByFrequencies() async {

    print('----------> Received Category:');

    print(this.widget.habitFrequency);

    var habits = await _habitService.readHabitsByFrequency(this.widget.habitFrequency);
    habits.forEach((habit) {
      setState(() {
        var habitsModel = Habit();

        habitsModel.id = habit['id'];
        habitsModel.habit = habit['habit'];
        habitsModel.habitDate = habit['habitDate'];
        habitsModel.habitFrequency = habit['frequency'];
        habitsModel.isFinished = habit['isFinished'];

        _habitList.add(habitsModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerNavigation(),
      appBar: AppBar(
        title: Text('Habits by Frequency'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _habitList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 8,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(_habitList[index].habit?? 'No Habit')
                          ],
                        ),
                        subtitle: Text(_habitList[index].habitFrequency ?? 'No Frequency'),
                        trailing: Text(_habitList[index].habitDate ?? 'No HabitDate'),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
