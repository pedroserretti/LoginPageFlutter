import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:login_page_pmsf/app/pages/home/home_page.dart';
import 'package:login_page_pmsf/app/ui/styles/text_styles.dart';

class HomeSideBar extends StatefulWidget {

  const HomeSideBar({ Key? key }) : super(key: key);

  @override
  State<HomeSideBar> createState() => _HomeSideBarState();
}

class _HomeSideBarState extends State<HomeSideBar> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();
    
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Página Inicial',
          baseStyle: context.textStyles.textBold.copyWith(color: Colors.white),
          selectedStyle: TextStyle(),
        ), 
        HomePage(showLoginPage: () {}
        )
      )
    ];
  }

   @override
    Widget build(BuildContext context) {
      return HiddenDrawerMenu(
        backgroundColorMenu: Colors.green,
        screens: _pages,
        initPositionSelected: 0,
      );
    }
  }