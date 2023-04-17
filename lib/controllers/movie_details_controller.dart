import 'package:get/get.dart';
import 'package:untitled/models/movie_detail_model.dart';
import 'package:untitled/services/api_service.dart';

class MovieDetailController extends GetxController {
  MovieDetailModel? movieDetailModel;

  Future<void> getMovieDetails(
      {required String imdbID,
      required String title,
      required String type,
      String? year,
      String? posterURL}) async {
    movieDetailModel =null;
    String finalURL = "";

    finalURL = '$finalURL&i=$imdbID';
    finalURL = '$finalURL&plot=long';
    var response = await ApiService.get(finalURL);
    movieDetailModel = MovieDetailModel.fromJson(response);
    update();
  }
}
