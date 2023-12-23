import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:todo_app_ui/components/home_app_bar.dart';
import 'components/user_message_component.dart';

void main() async {
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
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {},
                        icon: Icons.delete,
                        foregroundColor: Colors.red,
                        label: 'delete',
                        backgroundColor: Colors.white,
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
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit),
                Text('edit'),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: const Color.fromARGB(255, 164, 132, 250),
              child: const Padding(
                padding: EdgeInsets.only(bottom: 12, left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('data'),
                    Text('data'),
                  ],
                ),
              ),
            ),
          ),
        ],
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
