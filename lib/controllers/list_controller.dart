import 'package:mobx/mobx.dart';
import 'package:todomobx/controllers/todo_controller.dart';
part 'list_controller.g.dart';

class ListController = _ListControllerBase with _$ListController;

abstract class _ListControllerBase with Store {

  @observable
  String newTodoTitle = '';

  ObservableList<TodoController> todoList = ObservableList<TodoController>();

  @action
  void setNewTodoTitle(String value) => newTodoTitle = value;

  @action
  void addTodo() {
    todoList.insert(0, TodoController(newTodoTitle));
    newTodoTitle = '';
  }

  @computed
  bool get isFormValid => newTodoTitle.isNotEmpty;
}