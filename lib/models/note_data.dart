
import 'note_model.dart';

class NoteData {

  ///all list of notes
  List<Note> allNotes = [
    Note(id: 0, title: "First title", content: "First note"),
  ];


  /// get notes
  List<Note> getAllNotes(){
    return allNotes;
  }

  ///adding new node
  void addNewNote(Note note){
    allNotes.add(note);
  }

  ///update note
  void updateNote(Note note, String title, String content){
    for(int i = 0; i < allNotes.length; i++){
      if(allNotes[i].id == note.id){
        allNotes[i].title = title;
        allNotes[i].content = content;
      }
    }
  }

  ///delete note
  void deleteNote(Note note){
    allNotes.remove(note);
  }
}