import 'package:flutter/material.dart';
import 'package:netflix/model/model_movie.dart';
import 'package:netflix/screen/detail_screen.dart';

class CircleSlider extends StatelessWidget {
  final List<Movie> movies;

  const CircleSlider({Key key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('미리보기'),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeCirecleImages(context,movies),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeCirecleImages(BuildContext context, List<Movie> movies) {
  List<Widget> results =[];
  for(var i =0; i<movies.length;i++){
    results.add(InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute<Null>(fullscreenDialog: true,builder: (BuildContext context){
          return DetailScreen(movie: movies[i],);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            backgroundImage: AssetImage('images/'+movies[i].poster),
            radius: 48,
          ),
        ),
      ),
    ));
  }
  return results;
}
