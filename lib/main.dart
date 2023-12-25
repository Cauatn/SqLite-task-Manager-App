import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todo_app_ui/components/home_app_bar.dart';
import 'package:todo_app_ui/helpers/helper.dart';
import 'components/user_message_component.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Inicializando lista com dados vazia
  List<Map<String, dynamic>> allData = [];

  void showForm() async {
    showModalBottomSheet(
      context: context,
      builder: (_) => Text('oi'),
    );
  }

  @override
  void initState() {
    super.initState();
    refreshDados();
  }

  //Funçoes auxiliares que trocarei de lugar depois
  void refreshDados() async {
    final data = await SQLHelper.getItems();
    setState(() {
      allData = data;
    });
  }

  Future<void> deletarItem(id) async {
    await SQLHelper.deleteTask(id);
    refreshDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: ListView.builder(
        itemCount: allData.length,
        itemBuilder: (context, index) {
          return ((index == 0)
              ? UserMessage(tamanho: allData.length)
              : Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          deletarItem(allData[index]['id']);
                        },
                        icon: Icons.delete,
                        foregroundColor: Colors.red,
                        label: 'delete',
                        backgroundColor: Colors.white,
                      )
                    ],
                  ),
                  child: Task(
                    title: allData[index]['title'],
                    description: allData[index]['description'],
                  ),
                ));
        },
      ),
      floatingActionButton: _buildFAB(),
    );
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
        onPressed: () => {
          showForm(),
        },
      ),
    );
  }
}

class Task extends StatefulWidget {
  final String title;
  final String description;
  const Task({required this.title, required this.description, super.key});

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
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.title),
                    Text(widget.description != '' ? widget.description : ''),
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
