class Habit{
  int? id;
  late String habit;
  late String habitFrequency;
  late String habitDate;
  late int isFinished;

  habitMap() {
    var mapping = Map<String, dynamic>();

    mapping['id'] = id;
    mapping['habit'] = habit;
    mapping['habitFrequency'] = habitFrequency;
    mapping['habitDate'] = habitDate;
    mapping['isFinished'] = isFinished;

    return mapping;
  }
}