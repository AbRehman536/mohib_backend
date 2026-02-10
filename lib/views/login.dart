import 'package:flutter/material.dart';
import 'package:mohib_backend/services/auth.dart';
import 'package:mohib_backend/views/get_all_task.dart';
import 'package:mohib_backend/views/register.dart';
import 'package:mohib_backend/views/reset_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(children: [
        TextField(controller: emailController,),
        TextField(controller: passwordController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await AuthServices().loginUser(
                    email: emailController.text,
                    password: passwordController.text)
                    .then((val){
                      if(val.emailVerified == true){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> GetAllTask()));
                      }else{
                        isLoading = false;
                        setState(() {});
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Kindly Verify Your Email"),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text("Okay"))
                            ],
                          );
                        },);
                      }
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));

              }
        }, child: Text("Login")),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
        }, child: Text("Register")),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPassword()));
        }, child: Text("Reset Password")),
      ],),
    );
  }
}
