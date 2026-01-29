import 'package:flutter/material.dart';
import 'package:mohib_backend/models/task.dart';
import 'package:mohib_backend/services/task.dart';
import 'package:mohib_backend/views/create_task.dart';
import 'package:mohib_backend/views/get_Incompleted_Task.dart';
import 'package:mohib_backend/views/get_completed_task.dart';
import 'package:mohib_backend/views/get_faorite.dart';
import 'package:mohib_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetCompletedTask()));
          }, icon: Icon(Icons.circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetInCompletedTask()));
          }, icon: Icon(Icons.incomplete_circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetFavoriteTask()));
          }, icon: Icon(Icons.favorite)),
        ],
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
                    Checkbox(
                        value: taskList[index].isCompleted,
                        onChanged: (value)async{
                         try {
                            await TaskServices().markAsCompleted(
                                taskID: taskList[index].docId.toString(),
                                isCompleted: value!
                            );
                          }catch(e){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(e.toString())));
                         }
                        }),
                    IconButton(onPressed: ()async{
                      try{
                        await TaskServices().deleteTask(taskList[index].docId.toString());
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: ()async{
                      if(taskList[index].favorite!.contains("1")){
                        await TaskServices().removeFromFavorite(
                            taskID: taskList[index].docId.toString(),
                            userID: "1");
                      }else{
                        await TaskServices().addToFavorite(
                            taskID: taskList[index].docId.toString(),
                            userID: "1");
                      }
                    }, icon: Icon(taskList[index].favorite!.contains("1") ? Icons.favorite : Icons.favorite_border)),
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
