import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:techapp/models/user_list.model.dart';
import 'package:techapp/services/custon-dio.service.dart';

class UserRepository {
  ApiDio _api;
  UserRepository(this._api);

  Future<UserListModel> getAll() async {
    Response response = await _api.dio.get("/user");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.toString());
      var lst = UserListModel.fromJson(data);
      return lst;
    }
    return null;
  }
}
