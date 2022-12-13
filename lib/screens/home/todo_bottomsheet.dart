import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/api/api_util.dart';
import 'package:todoapp/constants/app_colors.dart';
import 'package:todoapp/constants/app_defaults.dart';
import 'package:todoapp/controllers/todos_controller.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/screens/home/home.dart';
import 'package:todoapp/screens/tasks/update_task.dart';
import 'package:todoapp/utilities/my_response.dart';
import 'package:todoapp/widgets/dialog_confirmation.dart';

class TodoBottomSheet extends StatefulWidget {
  final Todo toDo;
  const TodoBottomSheet({Key? key, required this.toDo}) : super(key: key);

  @override
  _TodoBottomSheetState createState() => _TodoBottomSheetState();
}

class _TodoBottomSheetState extends State<TodoBottomSheet> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  _deleteTask() async {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }

      MyResponse response = await TodoController.deleteATask(widget.toDo.id.toString());

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }

      if (response.success) {
        Fluttertoast.showToast(msg: 'Task deleted.', toastLength: Toast.LENGTH_LONG);
        Get.offAll(() => const HomeScreen());

      } else {
        showDialog(context: context,
            builder: (BuildContext context){
              return DialogConfirmation(
                  title: "Alert",
                  message: response.data ?? ApiUtil.SERVER_DEFAULT_ERROR
              );
            }
        );
      }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AutoSizeText(
                    widget.toDo.title!,
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    iconSize: 18,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Description: '),
                    Text(widget.toDo.description ?? '', style: const TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Status: '),
                    Text(widget.toDo.status ?? '', style: const TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Due Date: '),
                    Text(widget.toDo.dueDateTime ?? '', style: const TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Added On: '),
                    Text(DateFormat('dd MMM yyyy HH:mm:ss').format(DateTime.parse(widget.toDo.createdAt!)) ?? '', style: const TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Last Updated: '),
                    Text(DateFormat('dd MMM yyyy HH:mm:ss').format(DateTime.parse(widget.toDo.updatedAt!)) ?? '', style: const TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Okay'),
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)
                      ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateTask(todoTask: widget.toDo),
                        ),
                      );

                    },
                    child: const Text('Update'),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.red)
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _deleteTask();
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
