import 'package:flutter/material.dart';
import 'package:techapp/models/user.model.dart';

class DetailPage extends StatelessWidget {
  final UserModel user;

  const DetailPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.firstName),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero' + user.id,
            child: Image.network(
              user.picture,
            ),
          ),
        ),
      ),
    );
  }
}
