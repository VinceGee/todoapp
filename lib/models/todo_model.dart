class Todo {
  int? id;
  String? title;
  String? description;
  String? status;
  String? dueDateTime;
  String? createdAt;
  String? updatedAt;

  Todo({this.id,
        this.title,
        this.description,
        this.status,
        this.dueDateTime,
        this.createdAt,
        this.updatedAt});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    dueDateTime = json['due_date_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['due_date_time'] = this.dueDateTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  static List<Todo> getListFromJson(List<dynamic> jsonArray) {
    List<Todo> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Todo.fromJson(jsonArray[i]));
    }

    return list;
  }
}