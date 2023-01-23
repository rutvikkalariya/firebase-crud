import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SingleUser extends StatefulWidget {
  final u_id;
  const SingleUser({super.key, required this.u_id});

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  TextEditingController editnameController = TextEditingController();
  List<dynamic> myDataList = [];
  var email = "";
  var last_name = "";
  var first_name = "";
  var avatar = "";

  void fetchData() async {
    var url = Uri.parse('https://reqres.in/api/users?id=${widget.u_id}');
    var response = await http.get(url);

    print('id ${widget.u_id}');

    print('response status : ${response.statusCode}');
    print('response body : ${response.body}');

    Map<dynamic, dynamic> myMap = json.decode(response.body);

    setState(() {
      email = myMap['data']['email'];
      last_name = myMap['data']['last_name'];
      first_name = myMap['data']['first_name'];
      avatar = myMap['data']['avatar'];
    });
    // print("Name is ${first_name} last name is  ${last_name} ");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                  height: 100,
                  width: 100,
                  child: CachedNetworkImage(
                    imageUrl: avatar,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        CircularProgressIndicator(),
                  )
                  // CircleAvatar(
                  //     backgroundImage: ),
                  ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Name: ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan),
                      ),
                      Text(
                        '$first_name',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            EditName();
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                          )),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'last name: ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan),
                      ),
                      Text(
                        '$last_name',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            EditLastNmae();
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                          )),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'email: ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '$email',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            EditEmail();
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                          )),
                    ],
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        saveData();
                      },
                      child: Text('ADD')),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) => Profile()));

                  //       updateData();
                  //     },
                  //     child: Text('EDIT')),
                  ElevatedButton(
                      onPressed: () {
                        deleteData();
                      },
                      child: Text('DELETE')),
                ],
              ),
            ),
          ],
        ));
  }

// firebase

  saveData() async {
    final CollectionReference Userprofile =
        FirebaseFirestore.instance.collection('Userprofile');
    await Userprofile.add({
      "avatar": avatar,
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
    });
    print("Record Added");
  }

  // getData() async {
  //   final CollectionReference Userprofile =
  //       FirebaseFirestore.instance.collection('Userprofile');

  //   print(Userprofile.toString());
  // }

  updateData() async {
    final CollectionReference Userprofile =
        FirebaseFirestore.instance.collection('Userprofile');
    await Userprofile.doc("rTspJUdHN1Vh4vL58iVZ").update({
      "avatar": avatar,
      "first_name": first_name,
      "last_name": last_name,
      "email": email
    });
    print("Record Updated ");
  }

  deleteData() async {
    final CollectionReference Userprofile =
        FirebaseFirestore.instance.collection('Userprofile');
    await Userprofile.doc("rTspJUdHN1Vh4vL58iVZ").delete();
    print("Record Deleted ");
  }

  EditName() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter your name'),
          content: TextFormField(
            initialValue: first_name,
            // controller: editnameController,
            decoration: InputDecoration(
              hintText: "$first_name",
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                print('Cancel Pressed');
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('Saved'),
              onPressed: () {
                updateData();
                print('Saved Pressed');
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SingleUser(
                              u_id: widget.u_id,
                            )));
              },
            ),
          ],
        );
      },
    );
  }

  EditLastNmae() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter your last name'),
          content: TextFormField(
            initialValue: last_name,
            //controller: editnameController,
            decoration: InputDecoration(
              hintText: "$last_name",
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                print('Cancel Pressed');
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('Saved'),
              onPressed: () {
                updateData();
                print('Saved Pressed');
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SingleUser(
                              u_id: widget.u_id,
                            )));
              },
            ),
          ],
        );
      },
    );
  }

  EditEmail() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter your email'),
          content: TextFormField(
            initialValue: email,
            //controller: editnameController,
            decoration: InputDecoration(
              hintText: "$email",
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                print('Cancel Pressed');
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('Saved'),
              onPressed: () {
                updateData();
                print('Saved Pressed');
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SingleUser(
                              u_id: widget.u_id,
                            )));
              },
            ),
          ],
        );
      },
    );
  }
}
