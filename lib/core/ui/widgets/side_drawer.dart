import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vocab/core/navigation/routes.dart' as MyRoute;

import 'headline_text.dart';

class SideDrawer extends StatelessWidget {
  final Page page;
  const SideDrawer({Key key, @required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text("shakleenishfar@gmail.com"),
            accountName: HeadlineText(
              text: "Shakleen Ishfar",
              color: Colors.white,
            ),
            currentAccountPicture: CircleAvatar(backgroundColor: Colors.white),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Search'),
           // selected: page == MyRoute.Page.HomePage,
            onTap: () {
              if (page != MyRoute.Page.HomePage) {
                Navigator.pushReplacementNamed(
                  context,
                  MyRoute.Page.HomePage.toString(),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.cards),
            title: Text('Saved'),
          //  selected: page == MyRoute.Page.CardPage,
            onTap: () {
              if (page != MyRoute.Page.CardPage) {
                Navigator.pushReplacementNamed(
                  context,
                  MyRoute.Page.CardPage.toString(),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.trophy),
            title: Text('Quiz'),
           // selected: page == MyRoute.Page.QuizPage,
            onTap: () {
              if (page != MyRoute.Page.QuizPage) {
                Navigator.pushReplacementNamed(
                  context,
                  MyRoute.Page.QuizPage.toString(),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.chartBar),
            title: Text('Stats'),
           // selected: page == MyRoute.Page.StatisticsPage,
            onTap: () {
              if (page != MyRoute.Page.StatisticsPage) {
                Navigator.pushReplacementNamed(
                  context,
                  MyRoute.Page.StatisticsPage.toString(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
