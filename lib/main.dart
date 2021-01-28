import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'src/utils/fade_route.dart';
import 'src/utils/routes.dart';

import 'src/pages/splash_page.dart';
import 'src/pages/login_page.dart';
import 'src/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final HttpLink httpLink = HttpLink(
    uri: 'https://graphqlzero.almansi.me/api',
  );

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client =
        ValueNotifier<GraphQLClient>(GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    ));

    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          title: 'UserApp',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.yellow,
            fontFamily: GoogleFonts.montserrat().fontFamily,
          ),
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(
                  builder: (_) => SplashPage(),
                );
                break;

              case Routes.LOGIN:
                return FadeRoute(widget: LoginPage());
                break;

              case Routes.HOME:
                return FadeRoute(widget: HomePage());
                break;

              default:
                return MaterialPageRoute(
                  builder: (_) => SplashPage(),
                );
            }
          },
        ),
      ),
    );
  }
}
