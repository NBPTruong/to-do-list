import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  bool isTaskContentEmpty(String content) {
    return content.trim().isEmpty;
  }

  //save new task
  void saveNewTask() {
    if (isTaskContentEmpty(_controller.text)) {
      // Hiển thị thông báo lỗi
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Error',
              style: GoogleFonts.roboto(
                color: Color.fromARGB(255, 149, 118, 233),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Task content cannot be left blank.',
              style: GoogleFonts.roboto(
                color: Color.fromARGB(255, 149, 118, 233),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'OK',
                  style: GoogleFonts.roboto(),
                ),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        db.toDoList.add([_controller.text, false]);
        _controller.clear();
      });
      Navigator.of(context).pop();
      db.updateDataBase();
    }
  }

  //create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    // Hiển thị công việc chưa hoàn thành
    for (int index = 0; index < db.toDoList.length; index++) {
      if (db.toDoList[index][1] == false) {
        widgets.add(
          ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          ),
        );
      }
    }

    // Hiển thị "Task completed"
    bool hasCompletedTasks = db.toDoList.any((task) => task[1] == true);
    if (hasCompletedTasks) {
      widgets.add(
        Padding(
          padding: EdgeInsets.only(left: 25, top: 10),
          child: Text(
            'Task completed',
            style: GoogleFonts.roboto(
              color: Color.fromARGB(255, 149, 118, 233),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      // Hiển thị công việc đã hoàn thành
      for (int index = 0; index < db.toDoList.length; index++) {
        if (db.toDoList[index][1] == true) {
          widgets.add(
            ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            ),
            // trailing: const Text(''),
            // children: const [
            //   Text('00:00:00'),
            // ],
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'To Do List',
          style: GoogleFonts.roboto(
            color: Color.fromARGB(255, 149, 118, 233),
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[100],
            ),
            child: IconButton(
              onPressed: createNewTask,
              icon: const Icon(Icons.add,
                  color: Color.fromARGB(255, 149, 118, 233), size: 32),
            ),
          ),
          // const SizedBox(width: 25),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              children: widgets,
            ),
          ),
        ],
      ),
    );
  }
}
