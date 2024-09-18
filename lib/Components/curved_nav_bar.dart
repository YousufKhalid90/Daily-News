import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 15.0,
        child: SizedBox(
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildBottomNavItem(
                icon: Icons.home_outlined,
                label: 'Home',
                index: 0,
              ),
              _buildBottomNavItem(
                icon: Icons.notifications_on_outlined,
                label: 'Notifications',
                index: 1,
              ),
              SizedBox(width: 48), // Spacer for the FAB
              _buildBottomNavItem(
                icon: Icons.bookmark_add_outlined,
                label: 'Saved',
                index: 2,
              ),
              _buildBottomNavItem(
                icon: Icons.person_outline_outlined,
                label: 'Profile',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return IconButton(
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: selectedIndex == index ? Color(0xFF005799) : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: selectedIndex == index ? Color(0xFF005799) : Colors.grey,
            ),
          ),
        ],
      ),
      onPressed: () => onItemTapped(index),
    );
  }
}
