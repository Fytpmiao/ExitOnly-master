import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../views/buy_product.dart';
import '../views/sell_product.dart';
import '../views/shopping_cart.dart';
import '../views/user_profile.dart';


class BottomNavbar extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _BrowseState();
  }
}

class _BrowseState extends State<BottomNavbar> {
  int _currentIndex = 0;
  final List<Widget> _children = [BuyProduct(),SellProduct(),ShoppingCart(),UserProfile()]; //List length is 4. Put tab page class here

@override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: _children[_currentIndex],
    bottomNavigationBar: BottomNavigationBar(
    onTap: onTabTapped,
    currentIndex: _currentIndex,
    type: BottomNavigationBarType.fixed,
    items: [
      BottomNavigationBarItem(
      icon: new Icon(Icons.shopping_bag_outlined),
      label: 'Buy',
      ),
      BottomNavigationBarItem(
      icon: new Icon(Icons.sell_outlined),
      label: 'Sell',
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      label: 'Cart',
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: 'Profile',
      )
    ],
    selectedLabelStyle: TextStyle(fontSize: 16),
    selectedItemColor: Colors.black,
    ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}

