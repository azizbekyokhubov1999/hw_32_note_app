import 'package:flutter/material.dart';
import 'package:hw_32_note_app/pages/details_page.dart';

import '../models/note_model.dart';
import '../services/hive_service/db_service.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});
  static const id = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> list = [];

  void loadNotes() async{
    list = await DBService.loadNotes();
    setState(() {});
  }

  void _openDetail()async{
    var result = await Navigator.pushNamed(context, DetailPage.id);
    if(result != null && result == true){
      loadNotes();
    }
  }

  Future<void> _openDetailWithNote(Note note)async{
   var result =  await Navigator.push(context, MaterialPageRoute(builder: (context) =>
       DetailPage(note: note)));
   if(result != null && result == true){
     loadNotes();
   }
  }

  @override
  void initState(){
    loadNotes();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child:  Text('Recent Notes',
            style: TextStyle(
                color: Colors.black,
                fontSize: 23,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
        ),
        leading: const Icon(
            Icons.menu,
          size: 30,
        ),
        actions: [
         IconButton(
             onPressed: (){},
             icon: const Icon(
                 Icons.search_rounded,
                 size: 30,
             ),
         ),
        ],
      ),
      body: GridView.builder(
       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
       itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
        crossAxisSpacing: 20
      ),
       itemBuilder: (context, index){
        return InkWell(
          onTap: (){
            _openDetailWithNote(list[index]);

          },
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Center(
                  child: Text(list[index].title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ) ,
                  ),
                ),
                ),
                Expanded(child: Center(
                  child: Text(
                      list[index].content,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                  ),
                ),
                ),
                Expanded(child: Center(
                  child: Text(
                    list[index].createTime.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
                ),

              ],
            ),
          ),
        );
       },
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            onPressed: (){
              _openDetail();
            },
            backgroundColor: Colors.redAccent,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            child: const Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
            ),
          ),
        ),
      ),
    
    );
  }
}
