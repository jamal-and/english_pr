import 'package:english_pr/logic/routes.dart';
import 'package:get/get.dart';

import '../../../general_exports.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: Text(widget.title),
          onTap: () {
            Get.toNamed(routePractice);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          generalBox,
          PromoCard(
            title: 'Practice Your\nPhrases/Quotes',
            onPress: () {
              Get.toNamed(routePractice);
            },
          ),
          PromoCard(
            alignment: AlignmentDirectional.centerEnd,
            title: '500 Quotes\nChallenge',
            onPress: () {
              Get.toNamed(
                routeQuotesChallenge,
                arguments: MyStorage().f500QuotesChallenge,
              );
            },
          ),
          PromoCard(
            title: 'Favorite Phrases',
            onPress: () {
              Get.toNamed(
                routeQuotesChallenge,
              );
            },
          ),
          generalBox,
        ],
      ),
    );
  }
}
