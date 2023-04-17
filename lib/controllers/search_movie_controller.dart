import 'package:get/get.dart';
import 'package:untitled/models/search_movie_model.dart';
import 'package:untitled/services/api_service.dart';

class SearchMovieController extends GetxController {
  SearchMovieModel? searchMovieModel;

  void sortByYear(){
    searchMovieModel!.Search!.sort((a,b) {
      return a!.Year!.compareTo(b!.Year!);
    });
    update();
  }

  void sortByName(){
    searchMovieModel!.Search!.sort((a,b) {
      return a!.Title!.compareTo(b!.Title!);
    });
    update();
  }


  Future<void> searchMovie({
    required String title,
    String? type,
    String? year,
    int? page,
  }) async {
    try {
      String finalURL = "";
      if (title.isNotEmpty) {
        finalURL = '$finalURL&s=$title';
      }
      if (year != null) {
        if (year.isNotEmpty && year != '') {
          int yearNumber = int.parse(year);
          if (yearNumber > 1900 && yearNumber < DateTime.now().year - 1) {
            finalURL = '$finalURL&y=$yearNumber';
          }
        }
      }
      if (type != null) {
        if (type.isNotEmpty && type != '') {
          if (type != 'all') finalURL = '$finalURL&type=$type';
        }
      }

      if (page != null) finalURL = '$finalURL&page=$page';
      var response = await ApiService.get(finalURL);
      searchMovieModel = SearchMovieModel.fromJson(response);
      print(searchMovieModel?.toJson());
      update();
    }  catch (e) {
      throw e.toString();
    }

  }
}
