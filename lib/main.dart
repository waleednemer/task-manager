import 'package:flutter/material.dart';
import 'package:task_manager_pro_max/add_record.dart';
import 'package:task_manager_pro_max/edit_record.dart';
import 'package:task_manager_pro_max/sql_helper.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: themeNotifier,
        builder: (_,ThemeMode currentMode, __){
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue, ),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home: const MyHomePage(),
          );
        });

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  bool _isLoading = false;
  List<Map<String, dynamic>> _journals = [];
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }


  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('تم الحذف بنجاح'),
    ));
    _refreshJournals();
  }


  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.tealAccent,
        title: const Text('Task Manager', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
              onPressed: (){
                MyApp.themeNotifier.value =
                MyApp.themeNotifier.value == ThemeMode.light
                    ? ThemeMode.dark : ThemeMode.light;
              },
              icon: Icon(MyApp.themeNotifier.value== ThemeMode.light
                  ?Icons.dark_mode
                  :Icons.light_mode )
          )
        ],
      ),
      body: _isLoading? const Center(
        child: CircularProgressIndicator(),
       ): ListView.builder(
        itemCount: _journals.length,
          itemBuilder: (context,index)=> Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            margin: const EdgeInsets.all(15),
            child: ListTile(
              title: Text(_journals[index]['title'], style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
              subtitle: Text(_journals[index]['description'], style: TextStyle(color: Colors.indigo),),
              trailing: SizedBox(
                width: 100,
                height: 100,
                child: Row(
                  children: [IconButton(
                      onPressed: (){
                        Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context)=>EditRecord(id:_journals[index]['id'].toString()))
                        );
                      },
                      icon: const Icon(Icons.edit_outlined, color: Colors.blue,),
                  ),
                    IconButton(
                        onPressed: ()=>_deleteItem(_journals[index]['id']),
                        icon: const Icon(Icons.delete, color: Colors.blue,)
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: ()async{
          String refresh  = await Navigator.push(
              context, MaterialPageRoute(
              builder: (context)=> const AddRecord(),
          ));
          if(refresh =='refresh'){
            _refreshJournals();
          }
        },
      ),
     );
  }
}
