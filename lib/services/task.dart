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
  Future markAsCompleted({required String taskID, required bool isCompleted})async{
    return await FirebaseFirestore.instance
        .collection("TaskCollection")
        .doc(taskID)
        .update({"isCompleted" : isCompleted});
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
  ///get Favorite Task
  Stream<List<TaskModel>> getFavoriteTask(String userID){
    return FirebaseFirestore.instance
        .collection("TaskCollection")
        .where("favorite", arrayContains: userID)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson)=> TaskModel.fromJson(taskJson.data())
    ).toList());
  }
///add to favorite
  Future addToFavorite({required String taskID, required String userID})
  async{
    return await FirebaseFirestore.instance
        .collection("TaskCollection")
        .doc(taskID)
        .update({"favorite" : FieldValue.arrayUnion([userID])});
  }
///remove from favorite
  Future removeFromFavorite({required String taskID, required String userID})
  async{
    return await FirebaseFirestore.instance
        .collection("TaskCollection")
        .doc(taskID)
        .update({"favorite" : FieldValue.arrayRemove([userID])});
  }
  ///get Task by Priority ID
  Stream<List<TaskModel>> getTaskByPriorityID(String priorityID){
    return FirebaseFirestore.instance
        .collection("TaskCollection")
        .where("priorityID", isEqualTo: priorityID)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson)=> TaskModel.fromJson(taskJson.data())
    ).toList());
  }
}