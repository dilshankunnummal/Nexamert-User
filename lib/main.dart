import 'package:flutter/material.dart';
import 'package:nexamart_user/common/widgets/splash_screen.dart';
import 'package:nexamart_user/constants/global_variables.dart';
import 'package:nexamart_user/features/auth/services/auth_service.dart';
import 'package:nexamart_user/provider/user_provider.dart';
import 'package:nexamart_user/router.dart';
// import 'package:nexamart/common/widgets/splash_screen.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/features/auth/services/auth_service.dart';
// import 'package:nexamart/provider/user_provider.dart';
// import 'package:nexamart/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sahachari',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme:
            const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const SplashScreen(),
    );
  }
}
