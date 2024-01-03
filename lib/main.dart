import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todo_app_ui/components/home_app_bar.dart';
import 'package:todo_app_ui/helpers/helper.dart';
import 'components/user_message_component.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Inicializando lista com dados vazia
  List<Map<String, dynamic>> allData = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void showForm(int? id) async {
    if (id != null) {
      // id != null -> update an existing item
      final existingJournal =
          allData.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
    }
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Adicione um novo item!',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Me conte sobre oque fará nele :)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 6,
                left: 6,
              ),
              child: TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.only(top: 15), // add padding to adjust text
                  isDense: true,
                  hintText: "Title",
                  iconColor: Colors.grey,
                  prefixIcon: Padding(
                    padding:
                        EdgeInsets.only(top: 10), // add padding to adjust icon
                    child: Icon(Icons.title_sharp),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 6,
                left: 6,
              ),
              child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                        top: 15,
                      ), // add padding to adjust text
                      isDense: true,
                      hintText: "Description",
                      iconColor: Colors.grey,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            top: 10), // add padding to adjust icon
                        child: Icon(Icons.edit_document),
                      ))),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 150,
              height: 45,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: const Color.fromARGB(255, 164, 132, 250),
                child: const Text(
                  "Criar novo item",
                  style: TextStyle(
                    color: Color.fromARGB(245, 255, 255, 255),
                  ),
                ),
                onPressed: () async {
                  await adicionarItem(
                    _titleController.text,
                    _descriptionController.text,
                  );

                  _titleController.clear();
                  _descriptionController.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    refreshDados();
  }

  /// Add Task Function
  Future<void> adicionarItem(String title, String description) async {
    await SQLHelper.createTask(
      title,
      description,
    );
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserMessage(tamanho: allData.length),
          Expanded(
            child: ListView.builder(
              itemCount: allData.length,
              itemBuilder: (context, index) {
                return Slidable(
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
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => showForm(allData[index]['id']),
                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),
                              const Text('edit'),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: const Color.fromARGB(255, 164, 132, 250),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 12, left: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    allData[index]['title'],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 26),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    allData[index]['description'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
          showForm(null),
        },
      ),
    );
  }
}
