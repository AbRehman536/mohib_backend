import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mohib_backend/models/task.dart';

class TaskServices{
  ///Create Task
  Future createTask(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection("TaskCollection")
        .add(model.toJson());
  }
  ///Update Task
  Future updateTask(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection("TaskCollection")
        .doc(model.docId)
        .update({"title" : model.title, "description": model.description});
  }
  ///Delete Task
  Future deleteTask(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection("TaskCollection")
        .doc(model.docId)
        .delete();
  }
  ///Mark As Completed
  Future markAsCompleted(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection("TaskCollection")
        .doc(model.docId)
        .update({"isCompleted" : model.isCompleted});
  }
  ///Get All Task
  ///Get Completed Task
  ///Get InCompleted Task
}