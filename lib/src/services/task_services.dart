import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:platillos/src/global/environment.dart';
import 'package:platillos/src/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TaskServices {
  Future<List<Task>> obtenerTodos() async {
    final prefs = await SharedPreferences.getInstance();
    String usuario = (prefs.getString('usuario') ?? "");
    final response = await http.get(
      '${Environment.apiUrl}?token=${usuario}',
      headers: {
        'authorization': 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd',
      },
    );

    if(response.statusCode == 200){
      final decoded = await json.decode(response.body);
      var lst = <Task>[];
      for(var tarea in decoded){
        var pl = new Task.fromJson(tarea);
        lst.add( pl );
      }
      return lst;

    }
    return [];

  }
  Future crear(String params) async {
    final response = await http.post(
      '${Environment.apiUrl}?token=${params}',
      headers: {
        'authorization': 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd',
      },
    );

    if(response.statusCode == 200){
      final decoded = await json.decode(response.body);
      return decoded["detail"];

    }
    return;

  }



}