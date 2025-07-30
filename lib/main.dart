import 'package:flutter/material.dart';
import 'screens/onboarding/onboarding_screen_1.dart';
import 'screens/onboarding/onboarding_screen_2.dart';
import 'screens/onboarding/onboarding_screen_3.dart';
import 'screens/onboarding/onboarding_screen_4.dart';

import 'screens/homepage/home_page.dart'; // Placeholder for your main homepage
import 'db/db_helper.dart';

void main() async {
  // Ensures binding is ready before using async DB ops
  WidgetsFlutterBinding.ensureInitialized();

  // This initializes the DB (if not already created) and runs `onCreate` logic
  //await DBHelper().database;

  // Now start the app
  runApp(MotoVaultApp());
}

class MotoVaultApp extends StatelessWidget {
  const MotoVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MotoVault',
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF3A86FF),
    secondary: const Color(0xFF8338EC),
    background: const Color(0xFFF8F9FA),
    surface: Colors.white,
    error: const Color(0xFFEF233C),
    brightness: Brightness.light,
            ),
    scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
      initialRoute: '/home',
      routes: {
        '/onboarding1': (context) => const OnboardingScreen1(),
        '/onboarding2': (context) => const OnboardingScreen2(),
        '/onboarding3': (context) => const OnboardingScreen3(),
        '/onboarding4': (context) => const OnboardingScreen4(),
        '/home': (context) => const HomePage(), // Will build later
      },
    );
  }
}