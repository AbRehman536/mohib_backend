import 'package:flutter/material.dart';
import 'package:mohib_backend/models/priority.dart';
import 'package:mohib_backend/services/priority.dart';
import 'package:mohib_backend/views/create_priority.dart';
import 'package:provider/provider.dart';

class GetAllPriority extends StatelessWidget {
  const GetAllPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Priority"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatePriority(model: PriorityTaskModel(), isUpdatedMode: false)));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: PriorityServices().getAllPriority(),
          initialData: [PriorityTaskModel()],builder: (context, child){
            List<PriorityTaskModel> priorityList = context.watch<List<PriorityTaskModel>>();
            return ListView.builder(itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(priorityList[index].name.toString()),
                trailing: Row(mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()async{
                      try{
                        await PriorityServices().deletePriority(priorityList[index].docId.toString());
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatePriority(model: PriorityTaskModel(), isUpdatedMode: true)));
                    }, icon: Icon(Icons.edit))
                    ],),
              );
            },);
      },),
    );
  }
}
