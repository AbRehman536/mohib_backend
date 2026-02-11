import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mohib_backend/models/user.dart';

class UserServices{
  String userCollection = "UserCollection";
  ///Create User
  Future createUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }
  ///Delete User
  Future deleteUser(String userID)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .delete();
  }
  ///Update User
  Future updateUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .update({"name": model.name, "phone": model.phone, "address": model.address});
  }
  ///Get User By ID
  Future<UserModel> getUserByID(String userID){
    return FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .get()
        .then((user)=> UserModel.fromJson(user.data()!));
  }
}