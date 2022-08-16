import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:platillos/src/models/task_model.dart';
import 'package:platillos/src/providers/task_provider.dart';
import 'package:platillos/src/widget/form_widget.dart';
import 'package:provider/provider.dart';


class listadoTask extends StatefulWidget {
  @override
  State<listadoTask> createState() => _listadoTaskState();

}


class _listadoTaskState extends State<listadoTask> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test Api Antonio'),
        ),
        body: _body(),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: "agregarBtn",
          onPressed: () {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => formulario(false)));
            });
          },
          label: const Text('Agregar'),
          icon: const Icon(Icons.create),
          backgroundColor: Colors.blueAccent,
          ),
    );
  }
  Widget _body(){
    final taskProvider = Provider.of<TaskProvider>(context);
    return Column(
      children: [
        Flexible(
          child: _listaTareas(context,taskProvider),
        ),
      ],
    );
  }
}

Widget _listaTareas(BuildContext context, TaskProvider taskProvider) {
  return FutureBuilder(
    future: taskProvider.obtenertareas(),
    builder: (_, AsyncSnapshot<List<Task>> snapshot){
      if(snapshot.hasError){
        return Text("Error");
      }
      if (snapshot.connectionState != ConnectionState.done) {
        return Center(
            child: CircularProgressIndicator()
        );
      }
      final tareas = snapshot.data;

      return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: tareas.length,
        itemBuilder: (_, int i){
          return _card(tareas[i], context,taskProvider);
        },
      );

    },
  );
}
Widget _card(Task tarea,BuildContext context,TaskProvider taskProvider) {

  String tareaEliminar = "${tarea.id}?";
  return Container(
    height: 90,
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Card(
      color: Colors.white60,
      child: Center(
        child: ListTile(
          leading: Icon(CupertinoIcons.bag),
          title: Text(tarea.title),
          trailing: FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Atencion'),
                content: Text("Deseas eliminar la tarea ${tarea.title}"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => taskProvider.borrarTarea(tareaEliminar).then((value) => Navigator.pop(context, 'OK')),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}