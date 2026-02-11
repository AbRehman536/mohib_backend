import 'package:flutter/material.dart';
import 'package:mohib_backend/models/user.dart';
import 'package:mohib_backend/services/user.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
   var userProvider = Provider.of<UserProvider>(context);
    super.initState();
    nameController = TextEditingController(
      text: userProvider.getUser().name.toString()
    );
    phoneController = TextEditingController(
      text: userProvider.getUser().phone.toString()
    );
    addressController = TextEditingController(
      text: userProvider.getUser().address.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar:AppBar(
        title: Text("Update Profile"),
      ),
      body: Column(
        children: [
          TextField(controller: nameController,),
          TextField(controller: phoneController,),
          TextField(controller: addressController,),
          isLoading ? Center(child: CircularProgressIndicator(),):
              ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                setState(() {});
                  await UserServices().updateUser(
                    UserModel(
                      docId: userProvider.getUser().docId,
                      name: nameController.text,
                      phone: phoneController.text,
                      address: addressController.text
                    )
                  ).then((val)async{
                    UserModel userModel = await UserServices()
                        .getUserByID(userProvider.getUser().docId.toString());
                    userProvider.setUser(userModel);
                    isLoading = false;
                    setState(() {});
                    showDialog(context: context, builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Success"),
                        content: Text("Profile Updated Successfully"),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }, child: Text("Okay"))
                        ],);
                    }, );
                    
                  });
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));

                }
              }, child: Text("Update Profile"))
        ],
      ),
    );
  }
}
