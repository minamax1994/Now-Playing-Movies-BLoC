import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import '../models/movie.dart';

class PlaylistBloc {
  final _playlistFetcher = PublishSubject<List<Movie>>();

  Observable<List<Movie>> get playlistStream => _playlistFetcher.stream;

  void fetchAllMovies() async {
    List<Movie> playlist = await _fetchDataFromApi();
    _playlistFetcher.sink.add(playlist);
  }

  void dispose() {
    _playlistFetcher.close();
  }

  Future<List<Movie>> _fetchDataFromApi() async {
    List<dynamic> mapPlaylist;
    Map<String, dynamic> result;
    http.Response response = await http.post(
        'http://api.themoviedb.org/3/movie/now_playing?api_key=31521ab741626851b73c684539c33b5a');
    result = json.decode(response.body);
    mapPlaylist = result['results'];
    List<Movie> playlist = List<Movie>();
    for (int i = 0; i < mapPlaylist.length; i++) {
      String name = mapPlaylist[i]['title'];
      String imageUrl = mapPlaylist[i]['poster_path'];
      int id = mapPlaylist[i]['id'];
      double popularity = mapPlaylist[i]['popularity'];
      int voteCount = mapPlaylist[i]['vote_count'];
      double rating = mapPlaylist[i]['vote_average'].toDouble();
      String releaseDate = mapPlaylist[i]['release_date'];
      String description = mapPlaylist[i]['overview'];
      String language = mapPlaylist[i]['original_language'];
      bool adult = mapPlaylist[i]['adult'];
      Movie movie = Movie(
        id: id,
        name: name,
        imageUrl: imageUrl,
        popularity: popularity,
        voteCount: voteCount,
        rating: rating,
        releaseDate: releaseDate,
        description: description,
        language: language,
        adult: adult,
      );
      playlist.add(movie);
    }
    return playlist;
  }
}

final PlaylistBloc playlistBloc = PlaylistBloc();
