import 'package:flutter/material.dart';

class SupplicationsScreen extends StatelessWidget {
  const SupplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Supplication",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your supplication',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter the number of supplications',

                      ),
                    ),

                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.blue,

                      child: MaterialButton(
                        onPressed: () {
                          // Add your save logic here
                          Navigator.pop(context); // Close the modal sheet
                        },
                        child: Text('Save',style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      appBar: AppBar(
        title: Text(
          "Supplications",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
