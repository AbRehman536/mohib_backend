import 'package:flutter/material.dart';
import 'package:mohib_backend/models/task.dart';
import 'package:mohib_backend/services/task.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';

class GetFavoriteTask extends StatelessWidget {
  const GetFavoriteTask({super.key});

  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Get Favorite Task"),
        ),
        body: StreamProvider.value(
          value: TaskServices().getFavoriteTask(userProvider.getUser().docId.toString()),
          initialData: [TaskModel()],builder: (context, child){
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.favorite),
              title: Text(taskList[index].title.toString()),
              subtitle: Text(taskList[index].description.toString()),
            );
          },);
        },)
    );
  }
}
