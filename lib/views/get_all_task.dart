import 'package:flutter/material.dart';
import 'package:mohib_backend/models/task.dart';
import 'package:mohib_backend/services/task.dart';
import 'package:mohib_backend/views/create_task.dart';
import 'package:mohib_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTask()));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: TaskServices().getAllTask(),
          initialData: [TaskModel()],
          builder: (context,child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(itemBuilder: (BuildContext context, int index) {
              return ListTile(
              leading: Icon(Icons.task),
                title: Text(taskList[index].title.toString()),
                subtitle: Text(taskList[index].description.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()async{
                      try{
                        await TaskServices().deleteTask(taskList[index].docId.toString());
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateTask(model: taskList[index])));
                    }, icon: Icon(Icons.edit))
                  ],
                ),
              );
            },);
          },
      ),
    );
  }
}
