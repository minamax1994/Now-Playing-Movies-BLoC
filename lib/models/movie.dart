import 'package:flutter/material.dart';

class Movie {
  String name;
  String imageUrl;
  int id;
  double popularity;
  int voteCount;
  double rating;
  String releaseDate;
  String description;
  String language;
  bool adult;
  bool isFavorite;

  Movie({
    @required this.name,
    @required this.imageUrl,
    @required this.id,
    @required this.popularity,
    @required this.voteCount,
    @required this.rating,
    @required this.releaseDate,
    @required this.description,
    @required this.language,
    @required this.adult,
    this.isFavorite = false,
  });
}
