
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:rider_app/screen/CustomerFeedback.dart';
import 'package:rider_app/screen/CutomerChatScreen.dart';
import 'package:rider_app/screen/FeedbackScreen.dart';
import 'package:rider_app/screen/FilterScreen.dart';
import 'package:rider_app/screen/ForgotPasswordScreen.dart';
import 'package:rider_app/screen/HomeScreen.dart';
import 'package:rider_app/screen/LoginSignUpScreen.dart';
import 'package:rider_app/screen/OrderScreen.dart';
import 'package:rider_app/screen/ProfileScreen.dart';
import 'package:rider_app/screen/SplashScreen.dart';
import 'package:rider_app/screen/OrderHistoryscreen.dart';
import 'package:rider_app/utils/Log.dart';

void main() {
  _initLog();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    runApp(App());
  });
}
void _initLog() {
  Log.init();
  Log.setLevel(Level.ALL);
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Rider App",
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => makeRoute(
                context: context,
                routeName: settings.name,
                arguments: settings.arguments),
            maintainState: true,
            fullscreenDialog: false,
          );
        });
  }


  Widget makeRoute({@required BuildContext context,
    @required String routeName,
    Object arguments}) {
    final Widget child = _buildRoute(context: context, routeName: routeName, arguments: arguments);
    return child;
  }

  Widget _buildRoute({@required BuildContext context, @required String routeName, Object arguments,}) {
    switch (routeName) {
      case '/':
        return SplashScreen();
      case '/loginSignUp':
        return LoginSignUpScreen();
      case '/home':
        return HomeScreen();
      case '/order':
        return OrderScreen("");
      case '/customerfeedback':
        return CustomerFeedback();
      case '/feedback':
        return FeedbackScreen();
      case '/forgot':
        return ForgotPasswordScreen();
      case '/orderhistory':
        return OrderHistoryscreen("","","","");
      case '/filter':
        return FilterScreen();
      case '/profile':
        return ProfileScreen();
      case '/chat':
        return CutomerChatScreen();
      default:
        throw 'Route $routeName is not defined';
    }
  }
}

