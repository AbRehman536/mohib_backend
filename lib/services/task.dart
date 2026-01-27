import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mohib_backend/models/task.dart';

class TaskServices{
  ///Create Task
  Future createTask(TaskModel model)async{
    DocumentReference documentReference = await FirebaseFirestore.instance
      .collection("TaskCollection")
        .doc();
    return await FirebaseFirestore.instance
        .collection("TaskCollection")
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }
  ///Update Task
  Future updateTask(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection("TaskCollection")
        .doc(model.docId)
        .update({"title" : model.title, "description": model.description});
  }
  ///Delete Task
  Future deleteTask(String taskID)async{
    return await FirebaseFirestore.instance
        .collection("TaskCollection")
        .doc(taskID)
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
  Stream<List<TaskModel>> getAllTask(){
    return FirebaseFirestore.instance
        .collection("TaskCollection")
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson)=> TaskModel.fromJson(taskJson.data())
    ).toList());
  }
  ///Get Completed Task
  Stream<List<TaskModel>> getCompletedTask(){
    return FirebaseFirestore.instance
        .collection("TaskCollection")
        .where("isCompleted", isEqualTo: true)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson)=> TaskModel.fromJson(taskJson.data())
    ).toList());
  }
  ///Get InCompleted Task
  Stream<List<TaskModel>> getInCompletedTask(){
    return FirebaseFirestore.instance
        .collection("TaskCollection")
        .where("isCompleted", isEqualTo: false)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson)=> TaskModel.fromJson(taskJson.data())
    ).toList());
  }
}