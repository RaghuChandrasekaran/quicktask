import 'package:flutter/material.dart';
import 'package:quicktask/data/todolocalstore.dart';
import 'package:quicktask/data/userremotestore.dart';
import '../widgets/todotile.dart';
import '../widgets/dialogbox.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final _taskInputController = TextEditingController();
  TodoLocalStore db = TodoLocalStore();
  UserRemoteStore userRemoteStore = UserRemoteStore();

  @override
  void initState() {
    //TODO: Use Stream builder to update the UI
    db.loadInitialTasks().whenComplete(() => setState(() {}));
    super.initState();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: _taskInputController,
              onSave: saveNewTask,
              onCancel: () => Navigator.of(context).pop());
        });
  }

  void saveNewTask() {
    if (_taskInputController.text.isNotEmpty) {
      setState(() {
        db.saveNewTask(_taskInputController.text, false);
        _taskInputController.clear();
      });
      Navigator.of(context).pop();
    }
  }

  void deleteTask(int index) {
    setState(() {
      db.deleteTask(index);
    });
  }

  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.checkTask(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () { 
              db.clearAllData();
              userRemoteStore.doUserLogout(context); 
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.getTasksCount(),
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.getTask(index).taskName,
            taskCompleted: db.getTask(index).taskCompleted,
            onChanged: (value) => checkboxChanged(value, index),
            deleteTask: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
