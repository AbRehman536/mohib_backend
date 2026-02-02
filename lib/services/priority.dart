import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/priority.dart';

class PriorityServices{
  ///Create Priority
  Future createPriority(PriorityTaskModel model)async{
    DocumentReference documentReference =
    await FirebaseFirestore.instance
        .collection("PriorityCollection")
        .doc();
    return await FirebaseFirestore.instance
        .collection("PriorityCollection")
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }
  ///Update Priority
  Future updatePriority(PriorityTaskModel model)async{
    return await FirebaseFirestore.instance
        .collection("PriorityCollection")
        .doc(model.docId)
        .update({"name" : model.name,});
  }
  ///Delete Priority
  Future deletePriority(String priorityID)async{
    return await FirebaseFirestore.instance
        .collection("PriorityCollection")
        .doc(priorityID)
        .delete();
  }
  ///Get All Priority
  Stream<List<PriorityTaskModel>> getAllPriority(){
    return FirebaseFirestore.instance
        .collection("PriorityCollection")
        .snapshots()
        .map((PriorityList) => PriorityList.docs
        .map((PriorityJson)=> PriorityTaskModel.fromJson(PriorityJson.data())
    ).toList());
  }
  ///Get Priority
  Future<List<PriorityTaskModel>> getPriority(){
    return FirebaseFirestore.instance
        .collection("PriorityCollection")
        .get()
        .then((PriorityList) => PriorityList.docs
        .map((PriorityJson)=> PriorityTaskModel.fromJson(PriorityJson.data())
    ).toList());
  }

}