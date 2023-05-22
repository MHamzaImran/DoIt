class Todo{
  var id;
  var title;
  var description;
  var category;
  var todoDate;
  var isFinished;

  todoMap(){
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['description'] = description;
    mapping['category'] = category;
    mapping['todoDate'] = todoDate;
    mapping['isFinished'] = isFinished;

    return mapping;
  }

}