import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';

class FavMoviesLocalDb extends GetxController {
  late final Box _box;
  List<Map<String, dynamic>> movieList = [];

  @override
  void onInit() {
    // TODO: implement onInit

    _box = Hive.box('favMovies');
    super.onInit();
  }

  addMovieToFav(Map<String, dynamic> movieData) async {
    _box.add(movieData);
    if (kDebugMode) {
      print('Info added to box! ${_box.length}');
    }
  }



   checkMovieContains(Map<String, dynamic> movie) {
    /*for(int i = 0 ; i<movieList.length;i++){
      print(movieList.elementAt(i)["imdbID"] );
      print(movie["imdbID"]);
      if(movieList.elementAt(i)["imdbID"] == movie["imdbID"]){
        return true ;
      }
      else{
        false ;
      }
    }*/

  }

  getFavMoviesList() {
    final data = _box.keys.map((key) {
      final item = _box.get(key);
      return {
        "title": item["title"],
        "poster": item["poster"],
        "imdbID": item["imdbID"],
        "year": item["year"],
      };
    }).toList();
    movieList = data.reversed.toList();
    if (kDebugMode) {
      print(movieList);
    }
    update();
  }

  deleteInfo(int index) {
    _box.deleteAt(index);
    movieList.removeAt(index);
    update();
    if (kDebugMode) {
      print('Item deleted from box at index: $index');
    }
  }
}
