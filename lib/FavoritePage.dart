import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_live_coding/DetailPage.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Favorite"),
        ),
        body: StreamBuilder(stream: Firestore.instance.collection('tvseries').where("favorite", isEqualTo: true).snapshots(),
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
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {

  return Column(
    children: <Widget>[
      new ListTile(
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailPage(document)),
          );
        },


      ),
      Divider(height: 5.0),

    ],
  );
}

