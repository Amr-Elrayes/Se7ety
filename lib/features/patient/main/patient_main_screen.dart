import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sa7ety/core/utils/colors.dart';
import 'package:sa7ety/core/utils/text_styles.dart';
import 'package:sa7ety/features/patient/home/presentation/pages/patient_home_screen.dart';
import 'package:sa7ety/features/patient/screens/my_appointment_screen.dart';
import 'package:sa7ety/features/patient/screens/patient_profile_screen.dart';
import 'package:sa7ety/features/patient/search/pages/search_screen.dart';

class PatientMainScreen extends StatefulWidget {
  const PatientMainScreen({super.key});

  @override
  State<PatientMainScreen> createState() => _MainPageState();
}

class _MainPageState extends State<PatientMainScreen> {
  int _selectedIndex = 0;
  final List _pages = [
    const PatientHomeScreen(),
    const SearchScreen(),
    MyAppointmentScreen(),
    PatientProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.2)),
          ],
        ),
        child: GNav(
          curve: Curves.easeOutExpo,
          rippleColor: Colors.grey,
          hoverColor: Colors.grey,
          haptic: true,
          tabBorderRadius: 20,
          gap: 5,
          activeColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.primaryColor,
          textStyle: TextStyles.textSize18.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          tabs: const [
            GButton(iconSize: 28, icon: Icons.home, text: 'الرئيسية'),
            GButton(icon: Icons.search, text: 'البحث'),
            GButton(
              iconSize: 28,
              icon: Icons.calendar_month_rounded,
              text: 'المواعيد',
            ),
            GButton(iconSize: 29, icon: Icons.person, text: 'الحساب'),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
