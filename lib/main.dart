import 'package:flutter/material.dart';
import 'package:platillos/src/pages/home_page.dart';
import 'package:platillos/src/providers/task_provider.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => TaskProvider() ),
      ],
      child: MaterialApp(
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (context) => HomePage()
        },
      ),
    );

  }
  
}