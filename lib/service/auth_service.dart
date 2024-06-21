
import 'package:flutter/cupertino.dart';
import 'package:recipes_app/service/http_service.dart';
import 'package:recipes_app/models/user.dart';


class AuthService {

  static final AuthService _singleton = AuthService._internal();
  final _httpService = HttpService();
  User? user;

  factory AuthService(){
    return _singleton;
  }

  AuthService._internal();

  Future<bool> login(String username,String password) async{

    try{
      var response = await _httpService.post("auth/login", {"username": username, "password": password});
      if(response?.statusCode == 200 && response?.data != null ){
          user = User.fromJson(response!.data);
          HttpService().setUp(bearerToken: user!.token);
          return true;
      }
    }catch (e){
      print(e);
    }
    // print(username);
      return false;
  }


}