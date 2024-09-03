
import 'package:flutter/material.dart';

class SupplicationsScreen extends StatelessWidget {
  const SupplicationsScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

      },child: Icon(Icons.add,color: Colors.white,),backgroundColor: Colors.blue,),
      appBar: AppBar(
        title: Text("Supplications",style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [

      ],),
    );
  }
}
