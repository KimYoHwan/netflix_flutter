
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix/model/model_movie.dart';
import 'package:netflix/widget/box_slider.dart';
import 'package:netflix/widget/carousel_silder.dart';
import 'package:netflix/widget/circle_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> streamData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamData = firestore.collection('movie').snapshots();
  }

  Widget _fetchData(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData ) return LinearProgressIndicator();
        return _buildBody(context,snapshot.data.docs);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }

  Widget _buildBody(BuildContext context, List<QueryDocumentSnapshot> snapshot) {
    List<Movie> movies = snapshot.map((d)=> Movie.fromSnapshot(d)).toList();
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            CarouselImage(movies: movies,),
            TopBar(),
          ],
        ),
        CircleSlider(
          movies: movies,
        ),
        BoxSlider(movies: movies,)
      ],
    );
  }
}
class TopBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        Image.asset('images/bbongflix_logo.png',fit: BoxFit.contain,height: 25,),
        Container(padding: EdgeInsets.only(right: 1),child:Text('TV 프로그램',style: TextStyle(fontSize: 14),),),
        Container(padding: EdgeInsets.only(right: 1),child:Text('영화',style: TextStyle(fontSize: 14),),),
        Container(padding: EdgeInsets.only(right: 1),child:Text('콘텐츠',style: TextStyle(fontSize: 14),),),
      ],),

    );
  }
}