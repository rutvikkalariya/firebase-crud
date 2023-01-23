import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'edit_data.dart';

class ListviewDetails extends StatefulWidget {
  const ListviewDetails({super.key});

  @override
  State<ListviewDetails> createState() => _ListviewDetailsState();
}

class _ListviewDetailsState extends State<ListviewDetails> {
  var fullname = [];
  var mobile = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listview Details'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Crud').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Card(
                child: ListTile(
                  title: Text(
                    document['Full_name'],
                  ),
                  subtitle: Text(
                    document['Mobile'],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            deleteData();
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  deleteData() async {
    final CollectionReference Crud =
        FirebaseFirestore.instance.collection('Crud');
    await Crud.doc("EnorHs7ApQa22IKyaYmQ").delete();
    print("Record Deleted ");
  }

  // updateData() async {
  //   final CollectionReference Userprofile =
  //       FirebaseFirestore.instance.collection('Userprofile');
  //   await Userprofile.doc("rTspJUdHN1Vh4vL58iVZ").update({
  //     "Full_name": avatar,
  //     "Mobile": first_name,
  //   });
  //   print("Record Updated ");
  // }
}
