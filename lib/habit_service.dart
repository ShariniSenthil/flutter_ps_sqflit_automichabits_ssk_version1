import 'package:flutter_ps_sqflit_automichabits_ssk/repository.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/habit.dart';

class HabitService {
  Repository? _repository;

  HabitService() {
    _repository = Repository();
  }

  saveHabit(Habit habit) async {
    print(habit.habit);
    print(habit.habitFrequency);
    print(habit.habitDate);
    print(habit.isFinished);
    return await _repository?.insertData('habits', habit.habitMap());
  }

  readHabits() async {
    return await _repository?.readData('habits');
  }

  readHabitsByFrequency(habitFrequency) async{
    return await _repository?.readDataByColumnName('habits','habitFrequency', habitFrequency);
  }
  updateHabit(Habit habit) async{
    return await _repository?.updateData('habits', habit.habitMap());
  }

  deleteHabit(habitId) async{
    return await _repository?.deleteData('habits', habitId);
  }
}