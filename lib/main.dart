import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_live_coding/DetailPage.dart';
import 'package:flutter_live_coding/FavoritePage.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Codelab",
      home: MyHome(),
      theme: ThemeData(
        primaryColor: Colors.red,
        dividerColor: Colors.grey,
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Codelab App"),
        actions: <Widget>[      // Add 3 lines from here...
          new IconButton(icon: const Icon(Icons.list), onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoritePage()));
          }),
        ],                      // ... to here.
      ),
      body: StreamBuilder(stream: Firestore.instance.collection('tvseries').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          print("get data");
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: new ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: const EdgeInsets.only(top: 10.0),
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
            ),
          );
        }));

  }

  void _pushSaved() {

  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {

  return Column(
    children: <Widget>[
      InkWell(
        child: new ListTile(
          key: new ValueKey(document.documentID),
          leading: Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(document["pic"]),
              fit: BoxFit.fill),

          )),
          title: Text(document["name"]),
          subtitle: Text(document["status"]),
          trailing: document["favorite"] ? Icon(Icons.favorite, color: Colors.red,):Icon(Icons.favorite_border, color: Colors.red),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPage(document)),
            );
          },


        ),
      ),
      Divider(height: 5.0),

    ],
  );
}


