import 'package:daily_supplications_app/shared/cubit/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/cubit.dart';

class SupplicationsScreen extends StatelessWidget {
  SupplicationsScreen({super.key});

  var form = GlobalKey<FormState>();
  var supplication = TextEditingController();
  var numberOfSupplications = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Add Supplication",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: supplication,
                            validator: (String ?value) {
                              if (value!.isEmpty) {
                                return "Please write a supplication";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your supplication',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (String ?value) {
                              if (value!.isEmpty) {
                                return "Please write  number Of a supplication";
                              }
                              return null;
                            },
                            controller: numberOfSupplications,
                            keyboardType: TextInputType.number,

                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter the number of supplications',

                            ),
                          ),

                          const SizedBox(height: 20,),
                          Container(
                            width: double.infinity,
                            height: 50,
                            color: Colors.blue,

                            child: MaterialButton(
                              onPressed: () {
                                if (form.currentState!.validate()) {
    AppCubit.get(context).insertToDb(title: supplication.text, number: int.parse(numberOfSupplications.text.toString())).then((value){
      Navigator.pop(context); // Close the modal sheet

    })             ;

                                }
                                // Add your save logic here
                              },
                              child: const Text('Save', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              ),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          appBar: AppBar(
            title: const Text(
              "Supplications",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            backgroundColor: Colors.blue,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.separated(scrollDirection: Axis.vertical,shrinkWrap: true,physics: BouncingScrollPhysics(),itemBuilder: (context,index)=>Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.blue,

                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text("${AppCubit.get(context).supplications[index]['title']}",style: TextStyle(
                        color: Colors.white
                            ,fontSize: 20,

                      ),),
                      Text("${AppCubit.get(context).supplications[index]['number']}",style: TextStyle(
                        color: Colors.white
                        ,fontSize: 20,
                      ),),

                    ],
                  ),
Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.grey[200],)),

                    ],
                  ),
                ),
              ),
            ), separatorBuilder: (context,index)=>SizedBox(height: 10,), itemCount: AppCubit.get(context).supplications.length),
          ),
        );
      },
    );
  }
}
