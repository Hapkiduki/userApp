import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:userapp/src/utils/colors.dart';
import 'package:userapp/src/utils/dimensions.dart';
import 'package:userapp/src/utils/routes.dart';
import 'package:userapp/src/utils/styles.dart';

import 'package:userapp/src/widgets/buttons.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool hasPermission = false;

  @override
  void initState() {
    _permission();
    super.initState();
  }

  _permission() async {
    var status = await Permission.location.status;

    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return;
    } else if (!status.isGranted) {
      status = await Permission.location.request();

      if (!status.isGranted) {
        return;
      }
    }

    setState(() {
      hasPermission = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.yellow,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: Dimensions.fromLTRB(context, .1, .3, .05, 0),
              child: Column(
                children: [
                  Text(
                    'userapp',
                    style: Styles.textTitle(context),
                  ),
                  SizedBox(
                    height: Dimensions.height(context) * .03,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.',
                    style: Styles.textBody(context),
                    maxLines: 4,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Dimensions.height(context) * .03,
                  ),
                  Buttons().circularButton(
                    context,
                    onPressed: hasPermission
                        ? () {
                            Navigator.pushNamed(context, Routes.LOGIN);
                          }
                        : null,
                    text: 'IR A LOGIN',
                  ),
                ],
              ),
            ),
            Positioned(
              top: Dimensions.height(context) * .49,
              left: 0,
              right: 0,
              child: Image(
                image: AssetImage('assets/images/download.png'),
                fit: BoxFit.none,
                alignment: Alignment.topCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
