import 'package:flutter/material.dart';

class SupplicationsScreen extends StatelessWidget {
   SupplicationsScreen({super.key});
var form=GlobalKey<FormState>();
var supplication=TextEditingController();
var  numberOfSupplications=TextEditingController();

  @override
  Widget build(BuildContext context) {
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
validator: (String ?value){
                          if(value!.isEmpty){
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
                        validator: (String ?value){
                          if(value!.isEmpty){
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
                            if(form.currentState!.validate()){
                              Navigator.pop(context); // Close the modal sheet

                            }
                            // Add your save logic here
                          },
                          child: const Text('Save',style: TextStyle(
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
      body: const Column(
        children: [],
      ),
    );
  }
}
