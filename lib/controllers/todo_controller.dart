import 'package:mobx/mobx.dart';
part 'todo_controller.g.dart';

class TodoController = _TodoController with _$TodoController;

abstract class _TodoController with Store {

  _TodoController(this.title);
  
  final String title;

  @observable
  bool done = false;
  
  @action
  void toggleDone() => done = !done;
}