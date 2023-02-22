class TodoModel {
  final String title;
  bool isDone;

  TodoModel({required this.title, required this.isDone});
  factory TodoModel.fromJson(Map<dynamic, dynamic> todo) {
    return TodoModel(title: todo['title'], isDone: todo['is_done'] ?? false);
  }
  Map<String, dynamic> toJson() {
    return {"title": title, "is_done": isDone};
  }
}