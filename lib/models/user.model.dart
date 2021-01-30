class UserModel {
  String id;
  String lastName;
  String firstName;
  String email;
  String title;
  String picture;

  UserModel(
      {this.id,
      this.lastName,
      this.firstName,
      this.email,
      this.title,
      this.picture});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    email = json['email'];
    title = json['title'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['email'] = this.email;
    data['title'] = this.title;
    data['picture'] = this.picture;
    return data;
  }
}
