
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/service/http_service.dart';

class DataService {

  static final _singleton =  DataService._internal();
  final _httpService = HttpService();

  DataService._internal();

  factory DataService(){
      return _singleton;
  }

  Future<List<Recipe>?> getRecipes(String recipe) async {
      String path = "recipes/";
      if(recipe.isNotEmpty){
          path += "meal-type/$recipe";
      }
      var response = await _httpService.get(path);
      if(response?.statusCode == 200 && response?.data != null){
        List data = response!.data["recipes"];
        List<Recipe> recipes = data.map((e) => Recipe.fromJson(e)).toList();
        return recipes;
      }



      print("Error Res Sir $response");
  }

}