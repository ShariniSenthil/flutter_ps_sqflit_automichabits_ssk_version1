class Journal{
  int? id;
  late String journal;
  late String journalDate;

  journalMap(){
    var mapping = Map<String, dynamic>();

    mapping['id'] = id;
    mapping['journal'] = journal;
    mapping['journalDate'] = journalDate;

    return mapping;
  }
}