import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/api/api_util.dart';
import 'package:todoapp/constants/app_colors.dart';
import 'package:todoapp/constants/app_defaults.dart';
import 'package:todoapp/controllers/todos_controller.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/screens/home/todo_bottomsheet.dart';
import 'package:todoapp/screens/tasks/add_new_task.dart';
import 'package:todoapp/utilities/my_response.dart';
import 'package:todoapp/widgets/custom_loading_indicator.dart';
import 'package:todoapp/widgets/dialog_confirmation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =  GlobalKey<RefreshIndicatorState>();
  List<Todo> allTodos = [];
  bool isInProgress = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _initiateAccData();
    }
  }

  _initiateAccData() async {
    _fetchTodos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refresh() async {
    if (mounted) {
      _fetchTodos();
    }
  }

  _fetchTodos() async {
    if (mounted) {
      setState(() {
        isInProgress = true;
      });
    }

    MyResponse myResponseShifts = await TodoController.getAllTodos();

    if (myResponseShifts.success) {
      allTodos = myResponseShifts.data!;
    } else {
      if (mounted) {
        showDialog(context: context,
            builder: (BuildContext context){
              return DialogConfirmation(
                  title: "Alert",
                  message: myResponseShifts.data ?? ApiUtil.SERVER_DEFAULT_ERROR
              );
            }
        );

      }
    }

    if (mounted) {
      setState(() {
        isInProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text('Todo App'),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const AddNewTask());
              },
              icon: const Icon(
                IconlyBold.plus,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          key: _refreshIndicatorKey,
          child: Stack(
            children: <Widget> [
              if(isInProgress)
                const CustomLoadingIndicator()
              else if(allTodos.isNotEmpty)
                _showRequests(allTodos)
              else
                const Center(child: Text('No todo tasks found.', style: TextStyle(fontWeight: FontWeight.bold),),)
            ],
          ),
        )
    );
  }

  _showRequests(List<Todo> allTodos) {
    List<Widget> listWidgets = [];

    for (int i = 0; i < allTodos.length; i++) {
      listWidgets.add(
          InkWell(
            onTap: () => {
              showModalBottomSheet(
                context: context,
                builder: (context) => TodoBottomSheet(toDo: allTodos[i]),
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDefaults.radius),
                    topRight: Radius.circular(AppDefaults.radius),
                  ),
                ),
              )
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              child: _singleRequest(allTodos[i]),
            ),
          ));
    }

    return Container(
      margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: ListView(
        shrinkWrap: true,
        children: listWidgets,
      ),
    );
  }

  _singleRequest(Todo toDo) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: AppDefaults.borderRadius),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(toDo.title!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('dd MMM yyyy HH:mm:ss').format(DateTime.parse(toDo.createdAt!)),
                          style: Theme.of(context).textTheme.bodyText1),
                      Text(toDo.status!,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: toDo.status == 'Complete' ? Colors.green : Colors.red))
                    ],
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );

  }

}
