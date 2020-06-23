import 'package:Prism/routing_constants.dart';
import 'package:Prism/theme/jam_icons_icons.dart';
import 'package:Prism/theme/themeModel.dart';
import 'package:Prism/ui/widgets/signInPopUp.dart';
import 'package:flutter/material.dart';
import 'package:Prism/main.dart' as main;
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Prism/globals.dart' as globals;

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: false,
          floating: true,
          snap: true,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                main.prefs.getBool("isLoggedin")
                    ? Container(
                        child: Image.asset(
                        "assets/images/bg4.jpg",
                        fit: BoxFit.cover,
                      ))
                    : Container(
                        child: Image.asset(
                        "assets/images/bgp.png",
                        fit: BoxFit.cover,
                      )),
                main.prefs.getBool("isLoggedin")
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          main.prefs.getString("googleimage") == null
                              ? Container()
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                      main.prefs.getString("googleimage")),
                                ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: main.prefs.getString("name") == null
                                    ? Container()
                                    : Text(
                                        main.prefs.getString("name"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                              ),
                              main.prefs.getString("email") == null
                                  ? Container()
                                  : Text(
                                      main.prefs.getString("email"),
                                      style: TextStyle(fontSize: 14),
                                    ),
                            ],
                          )
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate.fixed([
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Downloads',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              if (!main.prefs.getBool("isLoggedin")) {
                googleSignInPopUp(context, () {
                  Navigator.pushNamed(context, DownloadRoute);
                });
              } else {
                Navigator.pushNamed(context, DownloadRoute);
              }
            },
            leading: Icon(JamIcons.download),
            title: Text(
              "My Downloads",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Proxima Nova"),
            ),
            subtitle: Text(
              "See all your downloads",
              style: TextStyle(fontSize: 12),
            ),
            trailing: Icon(JamIcons.chevron_right),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Personalisation',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Provider.of<ThemeModel>(context, listen: false).toggleTheme();
              main.RestartWidget.restartApp(context);
            },
            leading: Icon(JamIcons.brightness),
            title: Text(
              "Themes",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Proxima Nova"),
            ),
            subtitle: Text(
              "Change app theme",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'General',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Column(
            children: [
              // ListTile(
              //     leading: Icon(
              //       Icons.data_usage,
              //     ),
              //     title: Text(
              //       "Clear Cache",
              //       style: TextStyle(
              //           color: Theme.of(context).accentColor,
              //           fontWeight: FontWeight.w500,
              //           fontFamily: "Proxima Nova"),
              //     ),
              //     subtitle: Text(
              //       "Clear locally cached images",
              //       style: TextStyle(fontSize: 12),
              //     ),
              //     onTap: () {
              // DefaultCacheManager().emptyCache();
              // Fluttertoast.showToast(
              //     msg: "Cleared cache!",
              //     toastLength: Toast.LENGTH_LONG,
              //     timeInSecForIosWeb: 1,
              //     textColor: Colors.white,
              //     fontSize: 16.0);
              // }),
              // ListTile(
              //     leading: Icon(
              //       Icons.storage,
              //     ),
              //     title: new Text(
              //       "Clear Downloads",
              //       style: TextStyle(
              //           color: Theme.of(context).accentColor,
              //           fontWeight: FontWeight.w500,
              //           fontFamily: "Proxima Nova"),
              //     ),
              //     subtitle: Text(
              //       "Clear downloaded images",
              //       style: TextStyle(fontSize: 12),
              //     ),
              //     onTap: () {
              // final dir = Directory("storage/emulated/0/Prism/");
              // try {
              //   dir.deleteSync(recursive: true);
              //   DefaultCacheManager().emptyCache();
              //   Fluttertoast.showToast(
              //       msg: "Deleted all downloads!",
              //       toastLength: Toast.LENGTH_LONG,
              //       timeInSecForIosWeb: 1,
              //       textColor: Colors.white,
              //       fontSize: 16.0);
              // } catch (e) {
              //   Fluttertoast.showToast(
              //       msg: "No downloads!",
              //       toastLength: Toast.LENGTH_LONG,
              //       timeInSecForIosWeb: 1,
              //       textColor: Colors.white,
              //       fontSize: 16.0);
              // }
              // }),
              ListTile(
                  leading: Icon(
                    JamIcons.share,
                  ),
                  title: new Text(
                    "Share Prism!",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "Quick link to pass on to your friends and enemies",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Share.share(
                        'Hey check out this amazing wallpaper app Prism https://github.com/Hash-Studios/Prism');
                  }),
            ],
          ),
          main.prefs.getBool("isLoggedin")
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'User',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                )
              : Container(),
          main.prefs.getBool("isLoggedin")
              ? Column(
                  children: [
                    ListTile(
                        leading: Icon(
                          JamIcons.heart,
                        ),
                        title: new Text(
                          "Clear Favorites",
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Proxima Nova"),
                        ),
                        subtitle: Text(
                          "Remove all favorites",
                          style: TextStyle(fontSize: 12),
                        ),
                        onTap: () {
                          // Fluttertoast.showToast(
                          //     msg: "Cleared all favorites!",
                          //     toastLength: Toast.LENGTH_LONG,
                          //     timeInSecForIosWeb: 1,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0);
                          // deleteData();
                        }),
                    ListTile(
                        leading: Icon(
                          JamIcons.log_out,
                        ),
                        title: new Text(
                          "Logout",
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Proxima Nova"),
                        ),
                        subtitle: Text(
                          "Sign out from your account",
                          style: TextStyle(fontSize: 12),
                        ),
                        onTap: () {
                          globals.gAuth.signOutGoogle();
                          main.RestartWidget.restartApp(context);
                        }),
                  ],
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Prism',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                  leading: Icon(
                    JamIcons.info,
                  ),
                  title: new Text(
                    "About",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "Know more about Prism",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Dialog signinPopUp = Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white10),
                          width: 300.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 150,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    color: Colors.white12),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Image.asset(
                                    'assets/images/appIcon.png',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "Prism is a collection of beautiful high quality wallpapers, curated into insightful categories, with robust back-end and beautiful UI. This app has been developed with WallHaven and Pexels API.",
                                  style: Theme.of(context).textTheme.headline6,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              FlatButton(
                                shape: StadiumBorder(),
                                color: Color(0xFFE57697),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'CLOSE',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => signinPopUp);
                  }),
              ListTile(
                  leading: Icon(
                    JamIcons.github,
                  ),
                  title: new Text(
                    "View Prism on GitHub!",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "Check out the code or contribute yourself",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () async {
                    launch("https://github.com/LiquidatorCoder/Prism");
                  }),
              // ListTile(
              //     leading: Icon(
              //       Icons.wallpaper,
              //     ),
              //     title: new Text(
              //       "API",
              //       style: TextStyle(
              //           color: Theme.of(context).accentColor,
              //           fontWeight: FontWeight.w500,
              //           fontFamily: "Proxima Nova"),
              //     ),
              //     subtitle: Text(
              //       "Prism uses Wallhaven API for wallpapers",
              //       style: TextStyle(fontSize: 12),
              //     ),
              //     onTap: () async {
              //       launch("https://wallhaven.cc/help/api");
              //     }),
              ListTile(
                  leading: Icon(
                    JamIcons.computer_alt,
                  ),
                  title: new Text(
                    "Version",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Proxima Nova"),
                  ),
                  subtitle: Text(
                    "2.0 stable",
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {}),
              ExpansionTile(
                leading: Icon(
                  JamIcons.users,
                ),
                title: new Text(
                  "Developers",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Proxima Nova"),
                ),
                subtitle: Text(
                  "Check out the cool devs!",
                  style: TextStyle(fontSize: 12),
                ),
                children: [
                  ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/AB.jpg"),
                      ),
                      title: new Text(
                        "LiquidatorCoder",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Proxima Nova"),
                      ),
                      subtitle: Text(
                        "Abhay Maurya",
                        style: TextStyle(fontSize: 12),
                      ),
                      onTap: () async {
                        launch("https://github.com/LiquidatorCoder");
                      }),
                  ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/AK.jpg"),
                      ),
                      title: new Text(
                        "CodeNameAkshay",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Proxima Nova"),
                      ),
                      subtitle: Text(
                        "Akshay Maurya",
                        style: TextStyle(fontSize: 12),
                      ),
                      onTap: () async {
                        launch("https://github.com/codenameakshay");
                      }),
                ],
              ),
            ],
          ),
        ]))
      ]),
    );
  }
}