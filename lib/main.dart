import 'package:eb_appsmoviles/providers/apiProvider.dart';
import 'package:eb_appsmoviles/screens/searchScreen.dart';
import 'package:eb_appsmoviles/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

final GoRouter router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const AppNavigation();
      },
      routes: [
        GoRoute(
            path: 'search',
            builder: (context, state) {
              return const HeroSearchScreen();
            })
      ]),
]);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => HeroProvider(),
        child: MaterialApp.router(
          title: 'Persons App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          routerConfig: router,
        ),
      ),
    );
  }
}
