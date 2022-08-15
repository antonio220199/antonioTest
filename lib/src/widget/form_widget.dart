import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:platillos/src/pages/home_page.dart';
import 'package:platillos/src/pages/listado_page.dart';
import 'package:platillos/src/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class formulario extends StatefulWidget {
  final bool login;
  formulario(this.login);

  @override
  _form createState() => _form();
}

enum TareaCompletada { incompleta, completada }

class _form extends State<formulario> {
  String usuario;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test Api Antonio'),
        ),
        body: _body()
    );
  }

  Widget _body(){
    return Column(
      children: [
        Flexible(
          child: _login(),
        )
      ],
    );
  }


  Widget _login(){
    final taskProvider = Provider.of<TaskProvider>(context,listen: false);
    taskProvider.refreshTask();
    TareaCompletada tarea = TareaCompletada.completada;
    TextEditingController nameController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    TextEditingController dateinput = TextEditingController();
    TextEditingController commentsController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController tagController = TextEditingController();
    DateTime dateTime = DateTime.now();
    dateinput.text="Fecha";
    _selectDate() async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: dateTime,
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime.now(),
          lastDate: DateTime(2101));
      if (picked != null) {
        dateTime = picked;
        //assign the chosen date to the controller
        dateinput.text = DateFormat('yyyy-MM-dd').format(dateTime);
      }
    }
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuario',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Titulo',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(1),
              child: RadioListTile<TareaCompletada>(
                title: const Text('Completada'),
                value: TareaCompletada.completada,
                groupValue: tarea,
                onChanged: (value) {
                  setState(() {
                    tarea = value;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(1),
              child: RadioListTile<TareaCompletada>(
                title: const Text('No Completada'),
                value: TareaCompletada.incompleta,
                groupValue: tarea,
                onChanged: (value) {
                  setState(() {
                    tarea = value;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder()
                ),
                readOnly: true, //this is important
                onTap: _selectDate,  //the method for opening data picker
                controller: dateinput,  //the controller
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: commentsController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Comentarios',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descripcion',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: tagController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tag',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Crear'),
                  onPressed: () {
                    crearUsuario(nameController.text, titleController.text, tarea.name, dateinput.text, commentsController.text, descriptionController.text, tagController.text);
                    if(!widget.login) SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => listadoTask()));
                    });
                    if(widget.login) SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => HomePage()));
                    });
                    },
                )
            ),
          ],
        ));
  }
  Future<void> crearUsuario(String login,String title,String complete,String date,String comments,String description,String tag,) async {
    final taskProvider = Provider.of<TaskProvider>(context,listen: false);
    final prefs = await SharedPreferences.getInstance();
    int tarea;
    if(complete=="completada"){
      tarea=1;
    }else{
      tarea=2;
    }
    SharedPreferences.setMockInitialValues({});
    setState(() {
      prefs.setString('usuario', login);
    });
    String params = "${login}&title=${title}&is_completed=${tarea}&due_date=${date}&comments=${comments}&description=${description}&tags=${tag}";
    taskProvider.crearTarea(params);
  }
}