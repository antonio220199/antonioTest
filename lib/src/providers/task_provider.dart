import 'package:flutter/material.dart';
import 'package:platillos/src/models/task_model.dart';
import 'package:platillos/src/services/task_services.dart';

class TaskProvider extends ChangeNotifier{
  List<Task> tareas;


  Future<List<Task>> obtenertareas() async {

    if(this.tareas != null){
      return tareas;
    }

    var service = new TaskServices();
    this.tareas = await service.obtenerTodos();
    notifyListeners();
  }

  Future<List<Task>> crearTarea(String params) async {
    var service = new TaskServices();
    this.tareas = await service.crear(params);
  }

  Future<List<Task>> refreshTask() async {
    var service = new TaskServices();
    this.tareas = await service.obtenerTodos();
    notifyListeners();
  }
}