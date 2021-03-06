import 'package:flutter/material.dart';
import 'package:sai_collections/components/component.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/main_components.dart';

class Home extends StatefulWidget {  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String email = 'Guest';
  bool internet = false;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    sample();
  }

  void sample() async {
    final pref = await SharedPreferences.getInstance();
    internet = await Component().checkInternetConnection(context);
    print(internet);

    if (pref.getString('email') != null) {
      email = pref.getString('email');
    }

    setState(() {});
  }

  Future<Null> refresh() async {
    internet = await Component().checkInternetConnection(context);
    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.45;
    double width = MediaQuery.of(context).size.width * 0.21;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Sai Collections"),
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        elevation: 0.0,
        bottom: PreferredSize(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            color: Theme.of(context).accentColor,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(0.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          )
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Theme.of(context).accentColor,
        onRefresh: refresh,
        child: internet
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MainComponent(name: 'T-Shirt', imageName: 't_shirt'),
                    SizedBox(
                      height: 15.0,
                    ),
                    MainComponent(
                        name: 'Formal Shirts', imageName: 'formal_shirts'),
                    SizedBox(
                      height: 15.0,
                    ),
                    MainComponent(name: 'Jeans', imageName: 'jeans'),
                    SizedBox(
                      height: 15.0,
                    ),
                    MainComponent(name: 'Lowers', imageName: 'lowers'),
                  ],
                ),
              )
            : GestureDetector(
                child: ListView(
                  padding: EdgeInsets.only(top: height, left: width),
                  children: <Widget>[
                    Text(
                      "No Internet Connection",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 20.0),
                    ),
                  ],
                ),
                onTap: () {
                  Component().showInSnackBar(
                      context, _scaffoldKey, "Pull For Refreshing Page");
                },
              ),
      ),
      drawer: Component().showDrawer(context, email),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: <Widget>[
      //             CircleAvatar(
      //               backgroundColor: Theme.of(context).primaryColor,
      //               child: Text(
      //                 email[0].toUpperCase(),
      //                 style: TextStyle(color: Theme.of(context).accentColor),
      //               ),
      //               radius: 25.0,
      //             ),
      //             SizedBox(
      //               height: 20.0,
      //             ),
      //             Text(
      //               "Hello,",
      //               style: TextStyle(
      //                   color: Theme.of(context).primaryColor, fontSize: 30.0),
      //             ),
      //             SizedBox(
      //               height: 10.0,
      //             ),
      //             Text(
      //               email,
      //               style: TextStyle(
      //                   color: Theme.of(context).primaryColor, fontSize: 15.0),
      //             )
      //           ],
      //         ),
      //         decoration: BoxDecoration(
      //           color: Theme.of(context).accentColor,
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.home,
      //           color: Theme.of(context).accentColor,
      //         ),
      //         title: Text(
      //           "Home",
      //           style: Theme.of(context).textTheme.subhead,
      //         ),
      //         onTap: () {
      //           Navigator.pushReplacement(
      //               context, MaterialPageRoute(builder: (context) => Home()));
      //         },
      //       ),
      //       Container(
      //         margin: const EdgeInsets.symmetric(horizontal: 10.0),
      //         color: Theme.of(context).accentColor,
      //         height: 1.0,
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.shopping_cart,
      //           color: Theme.of(context).accentColor,
      //         ),
      //         title: Text(
      //           "My Cart",
      //           style: Theme.of(context).textTheme.subhead,
      //         ),
      //         onTap: () {},
      //       ),
      //       Container(
      //         margin: const EdgeInsets.symmetric(horizontal: 10.0),
      //         color: Theme.of(context).accentColor,
      //         height: 1.0,
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.favorite,
      //           color: Theme.of(context).accentColor,
      //         ),
      //         title: Text(
      //           "My Wishlist",
      //           style: Theme.of(context).textTheme.subhead,
      //         ),
      //         onTap: () {},
      //       ),
      //       Container(
      //         margin: const EdgeInsets.symmetric(horizontal: 10.0),
      //         color: Theme.of(context).accentColor,
      //         height: 1.0,
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.add_shopping_cart,
      //           color: Theme.of(context).accentColor,
      //         ),
      //         title: Text(
      //           "My Order",
      //           style: Theme.of(context).textTheme.subhead,
      //         ),
      //         onTap: () {},
      //       ),
      //       Container(
      //         margin: const EdgeInsets.symmetric(horizontal: 10.0),
      //         color: Theme.of(context).accentColor,
      //         height: 1.0,
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.person,
      //           color: Theme.of(context).accentColor,
      //         ),
      //         title: Text(
      //           "My Account",
      //           style: Theme.of(context).textTheme.subhead,
      //         ),
      //         onTap: () {},
      //       ),
      //       Container(
      //         margin: const EdgeInsets.symmetric(horizontal: 10.0),
      //         color: Theme.of(context).accentColor,
      //         height: 1.0,
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.power_settings_new,
      //           color: Theme.of(context).accentColor,
      //         ),
      //         title: Text(
      //           "Log Out",
      //           style: Theme.of(context).textTheme.subhead,
      //         ),
      //         onTap: () async {
      //           final pref = await SharedPreferences.getInstance();
      //           FirebaseAuth.instance.signOut().then((value) {
      //             pref.setBool('status', false);
      //             pref.setString('email', 'Guest');
      //             Navigator.pushReplacement(context,
      //                 MaterialPageRoute(builder: (context) => Login()));
      //           }).catchError((e) {
      //             print(e);
      //           });
      //         },
      //       ),
      //       Container(
      //         margin:
      //             const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      //         color: Theme.of(context).accentColor,
      //         height: 1.0,
      //       ),
      //       Center(
      //           child: Text(
      //         "Created By GJJ1998",
      //         style: TextStyle(fontSize: 15.0, color: Colors.grey[700]),
      //       )),
      //       SizedBox(
      //         height: 7.0,
      //       ),
      //       Center(
      //           child: Text(
      //         "\u00A9 Copyright By Grass-International",
      //         style: TextStyle(fontSize: 12.0, color: Colors.grey),
      //       ))
      //     ],
      //   ),
      // ),
    );
  }
}
