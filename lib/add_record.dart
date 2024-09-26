import 'package:flutter/material.dart';
import 'package:task_manager_pro_max/sql_helper.dart';


class AddRecord extends StatefulWidget{
  const AddRecord({super.key});
  
  @override
  State<AddRecord> createState()=> _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {

final TextEditingController _titleController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
   
  Future<void> _addItem() async {
    await SQLHelper.createItem(_titleController.text, _descriptionController.text); 
  }
 


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.tealAccent,
        title: const Text('Add Task', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10),)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 1,),
                        borderRadius: BorderRadius.all(Radius.circular(10),)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2,),
                        borderRadius: BorderRadius.all(Radius.circular(10),)
                    ),
                  labelText: 'Title'
                ),
              ),
            ),
            const SizedBox(height: 2,),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                    hintText: 'description',
                    border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(10),)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 1,),
                        borderRadius: BorderRadius.all(Radius.circular(10),)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2,),
                        borderRadius: BorderRadius.all(Radius.circular(10),)
                    ),
                    labelText: 'description'
                ),
              ),
            ),
            const SizedBox(height: 3,),
            Center(
              child: ElevatedButton(
                onPressed: (){
                  _addItem();
                  _titleController.text = '';
                  _descriptionController.text = '';
                  Navigator.pop(context,'refresh');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 4,
                ),
                child: const Text('Add', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
