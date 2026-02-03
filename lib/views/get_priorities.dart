import 'package:flutter/material.dart';
import 'package:mohib_backend/models/priority.dart';
import 'package:mohib_backend/models/task.dart';
import 'package:mohib_backend/services/task.dart';
import 'package:provider/provider.dart';

class GetPriorities extends StatelessWidget {
  final PriorityTaskModel model;
  const GetPriorities({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${model.name} Priority Task"),
        ),
        body: StreamProvider.value(
          value: TaskServices().getTaskByPriorityID(model.docId.toString()),
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
