import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'listview_add.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              TextFormField(
                controller: mobileController,
                decoration: InputDecoration(labelText: 'Mobile'),
              ),
              SizedBox(height: 10),
              Container(
                width: 200,
                height: 40,
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    saveData();
                  },
                  child: Text('Submit'),
                ),
              ),
              // Container(
              //   width: 200,
              //   height: 40,
              //   margin: EdgeInsets.all(10.0),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       getData();
              //     },
              //     child: Text('Get'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  saveData() async {
    final CollectionReference Crud =
        FirebaseFirestore.instance.collection('Crud');
    await Crud.add({
      "Full_name": nameController.text,
      "Mobile": mobileController.text,
    });
    print('''
    Full Name : ${nameController}
    Mobile : ${mobileController}
    ''');
    print("Record Added");

    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => ListviewDetails())));
  }

  // getData() async {
  //   final CollectionReference Crud =
  //       FirebaseFirestore.instance.collection('Crud');
  //   print(Crud.toString());
  // }
}
