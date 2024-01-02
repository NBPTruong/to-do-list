import 'package:flutter/material.dart';
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

    if (_myBox.get("TODOLIST") == null ) {
      db.createInitialData();
    }else{
      db.loadData();
    }

    if (_myBox.get("TODOLISTCOMPLETE") == null ) {
      db.createInitialDataComplete();
    }else{
      db.loadDataComplete();
    }
    
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();
  

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      // if (value == true) {
      //   db.toDoListComplete.add(db.toDoList[index]);
      //   db.toDoList.removeAt(index);
      //   db.updateDataBase();
      // }
    });
    db.updateDataBase();
  }

  void checkBoxChangedComplete(bool? value, int index) {
    setState(() {
      db.toDoListComplete[index][1] = !db.toDoListComplete[index][1];
      if (value == false) {
        db.toDoList.add(db.toDoListComplete[index]);
        db.toDoListComplete.removeAt(index);
        db.updateDataBaseComplete();
      }
    });
    db.updateDataBaseComplete();
  }

  //save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
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

  void deleteTaskComplete(int index) {
    setState(() {
      db.toDoListComplete.removeAt(index);
    });
    db.updateDataBaseComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 149, 118, 233),
        title: const Text('To Do List',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            )),
        actions: [
          IconButton(
            onPressed: createNewTask,
            icon: const Icon(Icons.add, color: Colors.white, size: 32),
          )
        ],
      ),
      // body: db.toDoListComplete.isEmpty
      // ? ListView.builder(
      //         itemCount: db.toDoList.length,
      //         itemBuilder: (context, index) {
      //           return ToDoTile(
      //             taskName: db.toDoList[index][0],
      //             taskCompleted: db.toDoList[index][1],
      //             onChanged: (value) => checkBoxChanged(value, index),
      //             deleteFunction: (context) => deleteTask(index),
      //           );
      //         },
      //       )
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: db.toDoList[index][0],
                  taskCompleted: db.toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
          ),
          // const Text('To Do List Completed',
          //   style: TextStyle(
          //     color: Color.fromARGB(255, 149, 118, 233),
          //     fontSize: 20,
          //     fontWeight: FontWeight.bold,
          //   )),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: db.toDoListComplete.length,
          //     itemBuilder: (context, index) {
          //       return ToDoTile(
          //         taskName: db.toDoListComplete[index][0],
          //         taskCompleted: db.toDoListComplete[index][1],
          //         onChanged: (value) => checkBoxChangedComplete(value, index),
          //         deleteFunction: (context) => deleteTaskComplete(index),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
