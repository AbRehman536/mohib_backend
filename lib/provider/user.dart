import 'package:flutter/cupertino.dart';
import 'package:mohib_backend/models/user.dart';

class UserProvider extends ChangeNotifier{
  UserModel _userModel = UserModel();

  ///set User
  void setUser(UserModel model){
    _userModel = model;
    notifyListeners();
  }

  ///get User
  UserModel getUser() => _userModel;
}