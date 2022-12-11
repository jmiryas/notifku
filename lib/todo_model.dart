class TodoModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TodoModel({
    this.userId = 0,
    this.id = 0,
    this.title = "",
    this.completed = false,
  });

  factory TodoModel.fromJson(dynamic json) {
    return TodoModel(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      completed: json["completed"],
    );
  }
}
