import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'general_exports.dart';
import 'logic/routes.dart';

void main() async {
  await GetStorage.init();
  final SingletonFlutterWindow window =
      WidgetsFlutterBinding.ensureInitialized().window;
  await _ensureScreenSize(window);
  WidgetsFlutterBinding.ensureInitialized();
  // await Future.delayed(const Duration(milliseconds: 1000));
  runApp(const MyApp());
}

Future<void> _ensureScreenSize(dynamic window) async {
  return window.viewConfiguration.geometry.isEmpty
      ? Future<void>.delayed(
          const Duration(milliseconds: 10),
          () => _ensureScreenSize(window),
        )
      : Future<void>.value();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'English Home',
      theme: themeLight,
      //home: const MyHomePage(title: 'English Home'),
      //initialRoute: '/',
      getPages: routes,
    );
  }
}
