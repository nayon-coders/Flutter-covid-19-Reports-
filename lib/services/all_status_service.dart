import 'dart:convert';

import 'package:covid_tracker/services/utilites/ApiService.dart';
import 'package:http/http.dart' as http;
import '../Model/WorldStateModel.dart';

class StateService{

  //show all world satatus
  Future<WorldStateModel>fromWorldState()async {
    final response = await http.get(Uri.parse(ApiServise.WorldStatus));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
  }


  Future<void>fromCountriesStatus()async {
    var data;
    final response = await http.get(Uri.parse(ApiServise.AllCountris));
    data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return data;
    }else{
      throw Exception("Error");
    }
  }
}