class Profile{
  var image;
  var name;
  var email;

  profileMap(){
    var mapping = <String, dynamic>{};
    mapping['image'] = image;
    mapping['name'] = name;
    mapping['email'] = email;
    return mapping;
  }

}