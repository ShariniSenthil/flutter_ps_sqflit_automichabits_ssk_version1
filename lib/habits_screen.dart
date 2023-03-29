import 'package:flutter/material.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/create_habit_screen.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/drawer_navigation.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/edit_habit_screen.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habit.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habit_service.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({Key? key}) : super(key: key);

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {

  late HabitService _habitService;
  late List<Habit> _habitList;

  @override
  void initState() {
    super.initState();
    getAllHabits();
  }

  getAllHabits() async {
    _habitService = HabitService();
    _habitList = <Habit>[];

    var habits = await _habitService.readHabits();

    habits.forEach((habit) {
      setState(() {
        var habitModel = Habit();

        habitModel.id = habit['id'];
        habitModel.habit = habit['habit'];
        habitModel.habitFrequency = habit['habitFrequency'];
        habitModel.habitDate = habit['habitDate'];
        habitModel.isFinished = habit['isFinished'];

        _habitList.add(habitModel);
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
          'Habits',
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
          itemCount: _habitList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    print('---------->Edit or Delete invoked: Send Data');
                    print(_habitList[index].id);
                    print(_habitList[index].habit);
                    print(_habitList[index].habitFrequency);
                    print(_habitList[index].habitDate);
                    print(_habitList[index].isFinished);

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EdithabitScreen(),
                      settings: RouteSettings(
                        arguments: _habitList[index],
                      ),
                    ));
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_habitList[index].habit ?? 'No habit'),
                    ],
                  ),
                  subtitle: Text(_habitList[index].habitFrequency ?? 'No habitFrequency'),
                  trailing: Text(_habitList[index].habitDate ?? 'No habitDate'),
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
              MaterialPageRoute(builder: (context) => CreateToDoListScreen()));
          print('---------->add invoked');
        },
      ),
    );
  }
}
