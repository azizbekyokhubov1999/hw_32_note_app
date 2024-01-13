import 'package:flutter/material.dart';
import 'package:hw_32_note_app/models/note_model.dart';
import 'package:hw_32_note_app/services/hive_service/db_service.dart';

class DetailPage extends StatefulWidget {
  final Note? note;
  const DetailPage({super.key, this.note});
  static const id = '/details_page';

  @override
  State<DetailPage> createState() => _DetailPageState();
}


class _DetailPageState extends State<DetailPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<void> _store() async{
    if(widget.note == null){
       Note note = Note(
           id: titleController.text.hashCode,
           createTime: DateTime.now(),
           title: titleController.text,
           content: contentController.text
       );
       List<Note> list = await DBService.loadNotes();
       list.add(note);
       await DBService.storeNote(list);
       Navigator.pop(context, true);
    }
    else{
      Note note = Note(
        id: widget.note!.id,
        createTime: widget.note!.createTime,
        title: titleController.text,
        content: contentController.text
      );
      List<Note> list = await DBService.loadNotes();
      list.removeWhere((element) => element.id == note.id);
      list.add(note);
      await DBService.storeNote(list);
      Navigator.pop(context, true);
    }
  }

  void loadNote(Note? note){
    if(note != null){
      setState(() {
        titleController.text = note.title;
        contentController.text = note.content;
      });
    }
  }

  Future<void> delete() async{
    await DBService.removeNote();
  }

  @override
  void initState() {
    loadNote(widget.note);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 243, 191, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(253, 243, 191, 1),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Edit Note',
        style: TextStyle(
          color: Colors.black,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
        ),
        leading: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home_page');
          },
          child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async{
                await _store();
              },
              icon: const Icon(
                  Icons.done_outline,
                  color: Colors.black,
                  size: 30,
              ),
          ),
          IconButton(
              onPressed: () async{
                await delete();
                Navigator.pushNamed(context, '/home_page');
              },
              icon: const Icon(Icons.delete,
                color: Colors.black,
                size: 30,
              ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
       children: [
       Expanded(
         flex: 1,
         child: TextField(
              controller: titleController,
              maxLength: 25,
             textInputAction: TextInputAction.next,
             decoration: const InputDecoration(
               border: OutlineInputBorder(
                 borderSide: BorderSide.none,
               ),
               focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide.none,
               ),
               enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide.none,
               ),
               contentPadding:  EdgeInsets.all(15),
               hintText: "Title",
               hintStyle: TextStyle(
                 color: Colors.black,
                 fontSize: 30,
                 fontWeight: FontWeight.w700,
               ),
             ),
             style: const TextStyle(
               color: Colors.black87
             ),
           ),
       ),
         Expanded(
           flex: 8,
           child: TextField(
             controller: contentController,
             maxLines: 50,
             textInputAction: TextInputAction.next,
             style: const TextStyle(
                 color: Colors.black87
             ),
             decoration: const InputDecoration(
                 contentPadding:  EdgeInsets.all(15),
                 hintText: "Content",
                 hintStyle: TextStyle(
                   color: Colors.black,
                   fontSize: 16,
                   fontWeight: FontWeight.w400,
                 ),
               border: OutlineInputBorder(
                 borderSide: BorderSide.none,
               ),
               focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide.none,
               ),
               enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide.none,
               ),
             ),
           ),
         ),
       ],
     ),

    );
  }
}
