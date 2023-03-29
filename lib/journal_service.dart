

import 'package:flutter_ps_sqflit_automichabits_ssk/journal.dart';
import 'package:flutter_ps_sqflit_automichabits_ssk/repository.dart';

class JournalService{
  Repository? _repository;


  JournalService(){
    _repository = Repository();
  }

  saveJournal(Journal journal) async{
    print(journal.journal);
    print(journal.journalDate);
    return await _repository?.insertData('journals', journal.journalMap());
  }

  readJournal() async{
    return await _repository?.readData('journals');
  }

  readJournalById(journalId) async{
    return await _repository?.readDataById('journals', journalId);
  }

  updateJournal(Journal journal) async{
    return await _repository?.updateData('journals', journal.journalMap());
  }

  deleteJournal(journalId) async{
    return await _repository?.deleteData('journals', journalId);
  }
}