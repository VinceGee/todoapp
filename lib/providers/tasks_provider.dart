
import 'package:todoapp/controllers/todos_controller.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/providers/dispose_provider.dart';

class TodosProvider extends DisposableProvider {
  List<Todo> _allTodos = [];
  List<Todo> get allTodos => _allTodos;

  List<Todo> get allRequests {
    _getTodosFromAPI();
    return _allTodos;
  }

  void _getTodosFromAPI() async {
    var receivedTodos = await TodoController.getAllTodos();
    _allTodos.addAll(receivedTodos.data);
    notifyListeners();
  }

  @override
  void disposeValues() {
    _allTodos.clear();
  }

}