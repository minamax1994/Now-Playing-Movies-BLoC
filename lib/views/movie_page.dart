import 'package:flutter/material.dart';
import 'package:now_playing_movies_2/bloc/movie_bloc.dart';
import '../models/movie.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;

  MoviePage({@required this.movie});

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movie.name)),
      floatingActionButton: FloatingActionButton(
        child: widget.movie.isFavorite
            ? Icon(Icons.favorite, color: Colors.red)
            : Icon(Icons.favorite_border, color: Colors.white),
        onPressed: () {
          setState(() {
            if (widget.movie.isFavorite) {
              movieBloc.listOfFavorites.remove(widget.movie);
              widget.movie.isFavorite = false;
            } else {
              movieBloc.addToFavorite(widget.movie);
              widget.movie.isFavorite = true;
            }
          });
        },
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Hero(
              child: Image.network(
                'https://image.tmdb.org/t/p/w600_and_h900_bestv2${widget.movie.imageUrl}',
                alignment: AlignmentDirectional.topCenter,
              ),
              tag: widget.movie,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                widget.movie.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star_half, color: Colors.red),
                SizedBox(width: 5),
                Text(
                  '${widget.movie.rating}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                SizedBox(width: 20),
                Icon(Icons.record_voice_over, color: Colors.green),
                SizedBox(width: 5),
                Text(
                  '${widget.movie.voteCount}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                SizedBox(width: 20),
                Icon(Icons.sentiment_satisfied, color: Colors.blue),
                SizedBox(width: 5),
                Text(
                  '${widget.movie.popularity}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.calendar_today, color: Colors.pink),
                SizedBox(width: 5),
                Text(
                  '${widget.movie.releaseDate}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                SizedBox(width: 20),
                widget.movie.adult == true
                    ? Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Text('+18',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        ],
                      )
                    : Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Text('+18',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          Text(
                            '----',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      )
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            child: Center(
              child: Text(
                widget.movie.description,
                textAlign: TextAlign.center,
              ),
            ),
            padding: EdgeInsets.only(
                top: 10.0, left: 32.0, right: 32.0, bottom: 32.0),
          ),
        ],
      ),
    );
  }
}
