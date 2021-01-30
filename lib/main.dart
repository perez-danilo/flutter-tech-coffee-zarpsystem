import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:techapp/models/user_list.model.dart';
import 'package:techapp/repositories/user.repository.dart';
import 'package:techapp/services/custon-dio.service.dart';

final getIt = GetIt.instance;
void setupGetIt() {
  getIt.registerSingleton<ApiDio>(ApiDio());
  getIt.registerSingleton<UserRepository>(UserRepository(getIt<ApiDio>()));
}

void main() {
  setupGetIt();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: HomePage(),//versão com hero
      home: MyHomePage(), //versão codigicada na aula
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int contador = 0;
  var userRepository = getIt<UserRepository>();
  UserListModel users;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    users = await userRepository.getAll();
    print(users.data.length);
    print("loadData");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu app"),
      ),
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
                      return Container(
                        child: Card(
                          child: ListTile(
                            title: Text(item.firstName),
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage("${item.picture}"),
                              backgroundColor: Colors.transparent,
                            ),
                            trailing: Icon(Icons.favorite),
                            subtitle: Text(item.title),
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
