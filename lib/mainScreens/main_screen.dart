import 'package:chofair_driver/tabPages/earning_tab.dart';
import 'package:chofair_driver/tabPages/home_tab.dart';
import 'package:chofair_driver/tabPages/profile_tab.dart';
import 'package:chofair_driver/tabPages/ratings_tab.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin
{
  TabController? tabController;
  int selectedIndex = 0;

 onItemClicked(int index)
 {
  setState(() {
    selectedIndex = index;
    tabController!.index = selectedIndex;
  });
 }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          HomeTabPage(),
          EarningTabPage(),
          RatingTabPage(),
          ProfileTabPage()
        ], 
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: "Ganhos",
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Avaliações",
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
            ),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF222222),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex, 
        onTap: onItemClicked,
      ),

    );
  }
}
