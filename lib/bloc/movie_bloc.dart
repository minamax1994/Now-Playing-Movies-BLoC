import 'package:rxdart/rxdart.dart';
import '../models/movie.dart';

class MovieBloc {
  final _movieFavorites = PublishSubject<Movie>();
  List<Movie> listOfFavorites = [];

  Observable<Movie> get favoriteStream => _movieFavorites.stream;

  void addToFavorite(Movie movie) {
    listOfFavorites.add(movie);
    _movieFavorites.sink.add(movie);
  }

  void dispose() {
    _movieFavorites.close();
  }
}

final MovieBloc movieBloc = MovieBloc();
