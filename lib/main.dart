import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todo_app_ui/components/home_app_bar.dart';
import 'components/user_message_component.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter todo-app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ((index == 0)
              ? const UserMessage()
              : Slidable(
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {},
                        icon: Icons.delete,
                        label: 'delete',
                        backgroundColor: Colors.red,
                      )
                    ],
                  ),
                  child: const Task(),
                ));
        },
      ),
      floatingActionButton: _buildFAB(),
    );
  }
}

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.edit,
      ),
      title: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            color: Color.fromARGB(255, 164, 132, 250)),
        child: Text('title'),
      ),
      subtitle: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Color.fromARGB(255, 164, 132, 250)),
        child: Text('subtitle'),
      ),
    );
  }
}

/// Floating Action Button
Widget _buildFAB() {
  return SizedBox(
    width: 220,
    child: FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: const Color.fromARGB(255, 164, 132, 250),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Anote um novo projeto",
            style: TextStyle(
              color: Color.fromARGB(245, 255, 255, 255),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.add,
            color: Color.fromARGB(245, 255, 255, 255),
          ),
        ],
      ),
      onPressed: () => {},
    ),
  );
}
