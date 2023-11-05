//
import 'package:fitplus/screens/Subscriptions/subscriptions.dart';
import 'package:fitplus/screens/screenUser/homeUser.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class MainUser extends StatefulWidget {
  const MainUser({super.key});

  @override
  State<MainUser> createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreenUser(fav: false),
    HomeScreenUser(fav: true),
    const subscriptions(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: const Color(0xff48358e),
        unselectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        //items: const[
        //BottomNavigationBarItem (icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
        //  activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
        //label: "Home"),
        //BottomNavigationBarItem (icon:Icon(FluentSystemIcons.ic_fluent_star_regular),
        //  activeIcon: Icon(FluentSystemIcons.ic_fluent_star_filled),
        //label: "Favorites"),
        //BottomNavigationBarItem (icon:Icon(FluentSystemIcons.ic_fluent_class_regular),
        //  activeIcon: Icon(FluentSystemIcons.ic_fluent_class_filled),
        //label:"Subscriptions"),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_class_filled),
            label: 'Subscription',
          ),
        ],
      ),
    );
  }
}
