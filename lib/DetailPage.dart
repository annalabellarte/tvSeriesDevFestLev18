import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DocumentSnapshot serie;
  DetailPage(this.serie);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: BookmarkButton(serie),
        appBar: AppBar(
          title: Text(serie["name"]),

        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image(
                image: NetworkImage(serie["pic"]),
                height: 200.0,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      serie["name"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 2.0,
                    ),
                    SizedBox(height: 8.0,),
                    Text(serie["abstract"],
                    textAlign: TextAlign.justify,),
                    SizedBox(height:80.0),

                  ],
                ),
              ),
            ],
          ),

        )

    );
  }


}
class BookmarkButton extends StatefulWidget {
  DocumentSnapshot snapshot;

  BookmarkButton(this.snapshot);

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState(snapshot);
}

class _BookmarkButtonState extends State<BookmarkButton> {
  DocumentSnapshot snapshot;
  bool isFavorite;

  _BookmarkButtonState(this.snapshot){
    isFavorite = snapshot["favorite"];
  }
  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(onPressed: (){
      Firestore.instance.runTransaction((transaction) async {
        DocumentSnapshot freshSnap =
        await transaction.get(snapshot.reference);
        await transaction.update(
            freshSnap.reference, {'favorite': !freshSnap['favorite']});
        setState(() {
          isFavorite = !isFavorite;
        });
      });

    },
      child: Icon(isFavorite? Icons.favorite : Icons.favorite_border , color: Colors.white,),
      backgroundColor: Colors.red,);
  }
}



