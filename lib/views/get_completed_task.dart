import 'package:flutter/material.dart';
import 'package:mohib_backend/models/task.dart';
import 'package:mohib_backend/services/task.dart';
import 'package:provider/provider.dart';

class GetCompletedTask extends StatelessWidget {
  const GetCompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Completed Task"),
      ),
      body: StreamProvider.value(
          value: TaskServices().getCompletedTask(),
          initialData: [TaskModel()],builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.check),
                title: Text(taskList[index].title.toString()),
                subtitle: Text(taskList[index].description.toString()),
              );
            },);
      },)
    );
  }
}
