import 'package:flutter/material.dart';
import 'package:techapp/main.dart';
import 'package:techapp/models/user_list.model.dart';
import 'package:techapp/pages/detail/detail.page.dart';
import 'package:techapp/repositories/user.repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userRepository = getIt<UserRepository>();
  UserListModel users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    users = await userRepository.getAll();
    setState(() {
      users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
            child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Danilo Perez"),
              accountEmail: Text("daniloprogramacao@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  "D",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
                leading: Icon(Icons.star),
                title: Text("Favoritos"),
                subtitle: Text("meus favoritos..."),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  debugPrint('toquei no drawer');
                }),
            ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Perfil"),
                subtitle: Text("Perfil do usuário..."),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pop(context);
                })
          ],
        )),
      ),
      appBar: AppBar(title: Text("Tech Coffee")),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: (users == null || users.data == null)
                        ? 0
                        : users.data.length,
                    itemBuilder: (context, index) {
                      var item = users.data[index];
                      print(item.id);
                      return Hero(
                        tag: 'imageHero' + item.id,
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage("${item.picture}"),
                              backgroundColor: Colors.transparent,
                            ),
                            title: Text("${item.firstName} ${item.lastName}"),
                            subtitle: Text(item.email),
                            trailing: Icon(Icons.favorite),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return DetailPage(
                                  user: item,
                                );
                              }));
                            },
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
