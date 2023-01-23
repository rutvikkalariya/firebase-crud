import 'package:firebase_crud/Strats360_task/single_user.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  ListingPageState createState() => ListingPageState();
}

class ListingPageState extends State<ListingPage> {
  Future? myFuture;
  var myDataList = [];

  Future fetchData() async {
    try {
      var url = Uri.parse('https://reqres.in/api/users?page=2');
      var response = await http.get(url);

      print('response status : ${response.statusCode}');
      print('response body : ${response.body}');

      Map<String, dynamic> myMap = json.decode(response.body);
      myDataList = myMap['data'];
      return myDataList;
    } catch (e) {
      throw e;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listing of Users'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: FutureBuilder<dynamic>(
        future: myFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong :'));
          }
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: InkWell(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => imageDialog(
                                "A", myDataList[index]['avatar'], context));
                      },
                      child: CachedNetworkImage(
                        imageUrl: myDataList[index]['avatar'],
                        imageBuilder: (context, imageProvider) => Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            CircularProgressIndicator(),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(myDataList[index]['first_name']),
                        SizedBox(width: 5),
                        Text(myDataList[index]['last_name']),
                      ],
                    ),
                    subtitle: Text(myDataList[index]['email']),
                    //trailing: Text(myDataList[index]['id']),
                    onTap: () {
                      var u_id = myDataList[index]['id'];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SingleUser(
                                    u_id: u_id,
                                  ))));
                    },
                  ),
                );
              },
            ),
          ));
        },
      ),
    );
  }
}

Widget imageDialog(text, path, context) {
  return Dialog(
    child: Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(path), fit: BoxFit.cover)),
    ),
  );
}
