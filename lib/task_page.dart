import 'package:flutter/material.dart';

class TaskManagement extends StatefulWidget {
  const TaskManagement({super.key});

  @override
  State<TaskManagement> createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> {
  List<TaskItem> taskItems = [];
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();

  void _alertDialog() {
    showDialog<void>(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: const Text("Add Task Management"),
            contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 12),
            content: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      maxLength: 30,
                      controller: _titleController,
                      decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLength: 300,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Description';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _durationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Days Required',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            taskItems.add(TaskItem(
                                _titleController.text,
                                _descriptionController.text,
                                _durationController.text));
                          });
                          Navigator.pop(context);
                          _titleController.clear();
                          _descriptionController.clear();
                          _durationController.clear();
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                )),
          );
        });
  }

  void _deleteTask(TaskItem index) {
    setState(() {
      taskItems.remove(index);
    });
  }

  void _bottomDial(context, TaskItem taskItems) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Task   Details",
                  style: TextStyle(
                      color: Colors.amber, letterSpacing: 10, fontSize: 18),
                ),
                const SizedBox(height: 50),
                Text('Title: ${taskItems.title}'),
                const SizedBox(height: 18),
                Text('Description: ${taskItems.description}'),
                const SizedBox(height: 18),
                Text('Days need: ${taskItems.duration} days'),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    _deleteTask(taskItems);
                    Navigator.pop(context);
                  },
                  child: const Text('Delete Task'),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(' Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
                  color: Color.fromARGB(193, 211, 141, 219),
                  height: 1,
                ),
            itemCount: taskItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                onLongPress: () {
                  _bottomDial(context, taskItems[index]);
                },
                title: Text(taskItems[index].title),
                subtitle: Text(taskItems[index].description),
                trailing: Text(
                  "Days Required: ${taskItems[index].duration} days",
                  style: const TextStyle(color: Colors.amber),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(193, 211, 141, 219),
        onPressed: () => _alertDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskItem {
  String title, description;
  String duration;
  TaskItem(this.title, this.description, this.duration);
}
