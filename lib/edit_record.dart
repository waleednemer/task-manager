import 'package:flutter/material.dart';
import 'package:task_manager_pro_max/main.dart';
import 'package:task_manager_pro_max/sql_helper.dart';


class EditRecord extends StatefulWidget{
  final String id;
  const EditRecord({super.key, required this.id});

  @override
  State<EditRecord> createState()=> _EditRecordState();
}

class _EditRecordState extends State<EditRecord> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _updateItem() async {
    await SQLHelper.updateItem(
        int.parse(widget.id),  _titleController.text, _descriptionController.text);
  }

  Future<void> _getItem() async {
    var data = await SQLHelper.getItem( int.parse(widget.id) );
    _titleController.text = data[0]["title"] as String ;
    _descriptionController.text = data[0]["description"] as String  ;
  }


  @override
  void initState() {
    super.initState();
    _getItem();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.tealAccent,
        title: const Text('Edit Task', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
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
            const SizedBox(height: 10,),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                    hintText: 'description',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10),)),
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
            const SizedBox(height: 10,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _updateItem();
                  _titleController.text = '';
                  _descriptionController.text = '';
                  Navigator.pop(context, 'refresh');
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 4,
                  ),
                child: const Text('Update', style: TextStyle( color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
