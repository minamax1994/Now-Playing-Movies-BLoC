import 'package:flutter/material.dart';
import 'package:now_playing_movies_2/bloc/movie_bloc.dart';
import 'bloc/playlist_bloc.dart';
import 'models/movie.dart';
import 'views/movie_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    playlistBloc.fetchAllMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Now Playing Movies',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Now Playing Movies')),
        ),
        backgroundColor: Colors.red[50],
        body: StreamBuilder<List<Movie>>(
          stream: playlistBloc.playlistStream,
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData)
              return buildPlaylist(snapshot);
            else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildPlaylist(AsyncSnapshot<List<Movie>> snapshot) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int movieIndex) {
        return InkWell(
          onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return MoviePage(movie: snapshot.data[movieIndex]);
                }),
              ),
          child: GridTile(
            footer: StreamBuilder<Movie>(
                stream: movieBloc.favoriteStream,
                builder:
                    (BuildContext context, AsyncSnapshot<Movie> movieSnapshot) {
                  return GridTileBar(
                    title: Text(
                      snapshot.data[movieIndex].name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    trailing: (movieBloc.listOfFavorites
                            .contains(snapshot.data[movieIndex]))
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_border, color: Colors.white),
                    backgroundColor: Colors.red.withOpacity(.4),
                  );
                }),
            child: Hero(
              child: Image.network(
                'https://image.tmdb.org/t/p/w300_and_h300_bestv2${snapshot.data[movieIndex].imageUrl}',
                alignment: AlignmentDirectional.topCenter,
              ),
              tag: snapshot.data[movieIndex],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    playlistBloc.dispose();
    movieBloc.dispose();
    super.dispose();
  }
}
