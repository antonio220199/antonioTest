import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:platillos/src/providers/task_provider.dart';
import 'package:platillos/src/widget/form_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'listado_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    TextEditingController nameController = TextEditingController();
    final taskProvider = Provider.of<TaskProvider>(context,listen: false);
    taskProvider.refreshTask();
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Bienvenido',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Buscar tareas de un usuario',
                  style: TextStyle(fontSize: 20),
                )),
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
            SizedBox(height: 20,),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Buscar'),
                  onPressed: () {
                    loginUsuario(nameController.text);
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => listadoTask()));
                    });
                  },
                )
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                const Text('Deseas crear una tarea?'),
                TextButton(
                  child: const Text(
                    'Crear',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => formulario(true)));
                    });
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }

  Future<void> loginUsuario(String login) async {
    final prefs = await SharedPreferences.getInstance();
    SharedPreferences.setMockInitialValues({});
    setState(() {
      //usuario = (prefs.getString('usuario') ?? 0);
      prefs.setString('usuario', login);
    });
  }
}