import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiConnect {

  static var baseUrl = "http://plantemenode.herokuapp.com/";

  var login = baseUrl + "/users/login";
  var subscribe = baseUrl + "/users/signup";
  var getAllPlants = baseUrl + "/plantas";
  var getMyPlants = baseUrl + "/plantas/usuario";//token Authration


}