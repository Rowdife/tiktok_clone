import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TikTok Clone",
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: false,
        textTheme: Typography.blackMountainView,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        splashColor: Colors.transparent, // tunr off ink drop on entire app.
        highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: false,
        textTheme: Typography.whiteMountainView,
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: const Color(0xFFE9435A),
        ),
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade900),
        scaffoldBackgroundColor: Colors.grey.shade900,
        brightness: Brightness.dark,
      ),
      home: const MainNavigationScreen(),
    );
  }
}
