import 'package:get/get.dart';

import '../general_exports.dart';

const String routeSplash = '/';
const String routeBoarding = '/boarding';
const String routeLogin = '/login';
const String routeHome = '/home';
const String routePractice = '/practice';
const String routeQuotesChallenge = '/quotes-challenge';

List<GetPage> routes = [
  GetPage(
    name: routeSplash,
    page: () => const MyHomePage(title: 'English Home'),
  ),
  GetPage(
    name: routePractice,
    page: () => const Practice(),
  ),
  GetPage(
    name: routeQuotesChallenge,
    page: () => const ListedScreen(),
  ),
];
