import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:todoapp/api/api_util.dart';
import 'package:todoapp/constants/app_colors.dart';
import 'package:todoapp/constants/app_defaults.dart';
import 'package:todoapp/controllers/todos_controller.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/screens/home/home.dart';
import 'package:todoapp/utilities/my_response.dart';
import 'package:todoapp/widgets/custom_loading_indicator.dart';
import 'package:todoapp/widgets/dialog_confirmation.dart';

class UpdateTask extends StatefulWidget {
  final Todo todoTask;
  const UpdateTask({Key? key, required this.todoTask}) : super(key: key);

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  bool _isLoading = false;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _statusController;
  late TextEditingController _dueDateController;
  DateTime _selectedDate = DateTime.now(), initialDate = DateTime.now();
  List<bool> isSelected4 = [true, false];
  bool completeSelector = false;


  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _titleController = TextEditingController(text: widget.todoTask.title);
    _descriptionController = TextEditingController(text: widget.todoTask.description);
    _statusController = TextEditingController(text: widget.todoTask.status);
    _dueDateController = TextEditingController(text: widget.todoTask.dueDateTime);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _statusController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  _updateTask() async {

    String titleTodo = _titleController.text;
    String descTodo = _descriptionController.text;
    String statusTodo = _statusController.text;

    if(completeSelector){
      statusTodo = "Complete" ;
    } else {
      statusTodo = "InComplete";
    }

    if (titleTodo.isEmpty) {
      Fluttertoast.showToast(msg: 'Give the task a title', toastLength: Toast.LENGTH_LONG);
    } else if (descTodo.isEmpty) {
      Fluttertoast.showToast(msg: 'You need to give the task a description', toastLength: Toast.LENGTH_LONG);
    } else if (statusTodo.isEmpty) {
      Fluttertoast.showToast(msg: 'You need to give the task a status', toastLength: Toast.LENGTH_LONG);
    } else {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }

      MyResponse response = await TodoController.updateATask(widget.todoTask.id.toString(), titleTodo, descTodo,_selectedDate.toIso8601String(),  statusTodo);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }

      if (response.success) {
        Fluttertoast.showToast(msg: 'Task updated successfully.', toastLength: Toast.LENGTH_LONG);
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
  }

  void _confirmAddTask() {
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('No', style: TextStyle(color: AppColors.primary))
    );
    Widget continueButton = TextButton(
        onPressed: () async {
          Navigator.pop(context);
          _updateTask();
        },
        child: const Text('Yes, update', style: TextStyle(color: AppColors.primary))
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('Confirm Update To Do', style: TextStyle(fontSize: 18),),
      content: const Text('Are you sure you want to update this to do task?', style: TextStyle(fontSize: 14)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('Update Task: ${widget.todoTask.id}'),
        actions: const [

        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _titleController,
                        onChanged: (textValue) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Title',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          floatingLabelStyle:
                          MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                            final Color color = states.contains(MaterialState.error)
                                ? Theme.of(context).errorColor
                                : AppColors.primary;
                            return TextStyle(color: color, letterSpacing: 1.3);
                          }),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        onChanged: (textValue) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Description',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          floatingLabelStyle:
                          MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                            final Color color = states.contains(MaterialState.error)
                                ? Theme.of(context).errorColor
                                : AppColors.primary;
                            return TextStyle(color: color, letterSpacing: 1.3);
                          }),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ToggleButtons(
                        borderRadius: BorderRadius.circular(24),
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0; buttonIndex < isSelected4.length; buttonIndex++) {
                              if (buttonIndex == index) {
                                isSelected4[buttonIndex] = true;
                                completeSelector = true;
                              } else {
                                isSelected4[buttonIndex] = false;
                                completeSelector = false;
                              }
                            }
                          });
                        },
                        isSelected: isSelected4,
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("InComplete", style: TextStyle(color: AppColors.primary)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Completed", style: TextStyle(color: AppColors.primary)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: TextField(
                          controller: _dueDateController,
                          readOnly: true,
                          onTap: () {
                            _selectFromDate(context);
                          },
                          maxLines: 1,
                          cursorColor: Colors.grey[600],
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                          decoration: InputDecoration(
                            isDense: true,
                            border: const OutlineInputBorder(),
                            labelText: 'Due Date',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            floatingLabelStyle:
                            MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                              final Color color = states.contains(MaterialState.error)
                                  ? Theme.of(context).errorColor
                                  : AppColors.primary;
                              return TextStyle(color: color, letterSpacing: 1.3);
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              const CustomLoadingIndicator()
            else
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty){
                            _confirmAddTask();
                          } else {
                            Fluttertoast.showToast(msg: 'Please fill in all fields', toastLength: Toast.LENGTH_LONG);
                          }
                        },
                        child: const Text('Update Task'),
                      ),
                    ),
                    const SizedBox(height: AppDefaults.margin),
                  ],
                ),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<Null> _selectFromDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2122),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primary,
            colorScheme: const ColorScheme.light(primary: AppColors.primary, secondary: AppColors.primary),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dueDateController = TextEditingController(
            text: _selectedDate.toLocal().toString().split(' ')[0]);
      });
    }
  }

}
