import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade200,
              borderRadius: BorderRadius.circular(5),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                taskName,
                style: GoogleFonts.roboto(
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 149, 118, 233),
                ),
              ),
              Theme(
                data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                )),
                child: Transform.scale(
                  scale: 2.5,
                  child: Checkbox(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 149, 118, 233),
                    ),
                    value: taskCompleted,
                    onChanged: onChanged,
                    // materialTapTargetSize: MaterialTapTargetSize.padded,
                    activeColor: const Color.fromARGB(255, 149, 118, 233),
                    // visualDensity:
                    //     const VisualDensity(horizontal: -4, vertical: -4),
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
