import 'package:flutter/material.dart';
import 'package:mohib_backend/models/priority.dart';
import 'package:mohib_backend/models/task.dart';
import 'package:mohib_backend/services/priority.dart';
import 'package:mohib_backend/services/task.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  List<PriorityTaskModel> priorityList = [];
  PriorityTaskModel? _selectedPriority;
  @override
  void initState()async{
    super.initState();
    await PriorityServices().getPriority()
    .then((val){
      priorityList = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: Column(
        children: [
          TextField(controller: titleController,),
          TextField(controller: descriptionController,),
          DropdownButton(
            hint: Text("Select Priority"),
              value: _selectedPriority,
              items: priorityList.map((item){
                return DropdownMenuItem(
                  value: item,
                    child: Text(item.name.toString()));
              }).toList(),
              onChanged: (val){
              setState(() {
                _selectedPriority = val;
              });
              }),
          isLoading ? Center(child: CircularProgressIndicator(),)
          :ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await TaskServices().createTask(TaskModel(
                priorityID: _selectedPriority!.docId,
                title: titleController.text,
                description: descriptionController.text,
                isCompleted: false,
                createdAt: DateTime.now().millisecondsSinceEpoch
              )).then((val){
                isLoading = false;
                setState(() {});
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Success"),
                    content: Text("Task Created Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("Okay"))
                    ],);
                }, );
              });
            }catch(e){
              isLoading = false;
              setState(() {});
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Create Task"))
        ],
      ),
    );
  }
}
