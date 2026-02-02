import 'package:flutter/material.dart';
import 'package:mohib_backend/models/priority.dart';
import 'package:mohib_backend/services/priority.dart';

class CreatePriority extends StatefulWidget {
  final PriorityTaskModel model;
  final bool isUpdatedMode;
  const CreatePriority({super.key, required this.model, required this.isUpdatedMode});

  @override
  State<CreatePriority> createState() => _CreatePriorityState();
}

class _CreatePriorityState extends State<CreatePriority> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    if(widget.isUpdatedMode == true)
    nameController = TextEditingController(
        text: widget.model.name.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(widget.isUpdatedMode ? "Update Task" : "Create Task"),
        backgroundColor: widget.isUpdatedMode ? Colors.blue : Colors.yellow,
      ),
      body: Column(
        children: [
          TextField(
            controller:  nameController,
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  setState(() {});
                  if(widget.isUpdatedMode == true){
                    await PriorityServices().updatePriority(
                      PriorityTaskModel(
                        docId: widget.model.docId.toString(),
                        name: nameController.text,
                        createdAt: DateTime.now().millisecondsSinceEpoch))
                        .then((val){
                      isLoading = false;
                      setState(() {});
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Success"),
                          content: Text("Task Updated Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text("Okay"))
                          ],);
                      }, );
                    });
                  }
                  else{
                    await PriorityServices().createPriority(
                        PriorityTaskModel(
                            name: nameController.text,
                            createdAt: DateTime.now().millisecondsSinceEpoch))
                        .then((val){
                      isLoading = false;
                      setState(() {});
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Success"),
                          content: Text("Task Created Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text("Okay"))
                          ],);
                      }, );
                  });}
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));

                }
          }, child: Text(widget.isUpdatedMode ? "Update Task" : "Create Task"))
        ],
      ),
    );
  }
}
