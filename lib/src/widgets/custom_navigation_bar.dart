import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:userapp/src/utils/colors.dart';
import 'package:userapp/src/utils/dimensions.dart';
import 'package:userapp/src/utils/styles.dart';

class NavigationItem {
  final String icon;
  final String text;

  NavigationItem({@required this.icon, @required this.text});
}

class CustomNavigationBar extends StatefulWidget {
  final List<NavigationItem> items;
  final int selected;
  final ValueChanged<int> onTabbarChanged;

  CustomNavigationBar(
      {Key key,
      @required this.onTabbarChanged,
      this.selected = 0,
      @required this.items})
      : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with SingleTickerProviderStateMixin {
  final String path = 'assets/icons/';

  AnimationController controller;
  Animation<double> animationShake1;
  Animation<double> animationShake2;
  Animation<double> animationShake3;
  Animation<double> animationShake4;
  Animation<double> animationShake5;
  Animation<double> animationShake6;

  int _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.selected ?? 0;

    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    animationShake1 = Tween<double>(begin: 0, end: -0.5).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0, 0.1666, curve: Curves.easeOut)));

    animationShake2 = Tween<double>(begin: -0.5, end: 0.5).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.1666, 0.3333, curve: Curves.easeInOut)));

    animationShake3 = Tween<double>(begin: 0.5, end: -0.5).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.3333, 0.4999, curve: Curves.easeInOut)));

    animationShake4 = Tween<double>(begin: -0.5, end: 0.4).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.4999, 0.6666, curve: Curves.easeInOut)));

    animationShake5 = Tween<double>(begin: 0.4, end: -0.4).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.6666, 0.8333, curve: Curves.easeInOut)));

    animationShake6 = Tween<double>(begin: -0.4, end: 0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.8333, 1, curve: Curves.easeOut)));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller?.forward(from: 0);

    return Container(
      height: Dimensions.height(context) * .1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.items.length,
          (i) => GestureDetector(
            onTap: () {
              if (_currentIndex != i) {
                widget.onTabbarChanged(i);
                setState(() {
                  _currentIndex = i;
                });
              }
            },
            child: _currentIndex == i
                ? AnimatedBuilder(
                    animation: controller,
                    builder: (BuildContext context, Widget child) {
                      double angle = (animationShake1.value != -0.5)
                          ? animationShake1.value
                          : (animationShake2.value != 0.5)
                              ? animationShake2.value
                              : (animationShake3.value != -0.5)
                                  ? animationShake3.value
                                  : (animationShake4.value != 0.4)
                                      ? animationShake4.value
                                      : (animationShake5.value != -0.4)
                                          ? animationShake5.value
                                          : animationShake6.value;

                      return Transform.rotate(
                        angle: angle,
                        child: _item(context, i),
                      );
                    })
                : _item(context, i),
          ),
        ),
      ),
    );
  }

  Container _item(BuildContext context, int i) {
    return Container(
      padding: Dimensions.symetric(context, .03, .02),
      decoration: BoxDecoration(
        color: _currentIndex == i ? CustomColors.yellow : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SvgPicture.asset(path + widget.items[i].icon),
          if (_currentIndex == i)
            Padding(
              padding: Dimensions.horizontal(context, .02),
              child: Text(
                widget.items[i].text,
                style: Styles.itemMenu(context),
              ),
            ),
        ],
      ),
    );
  }
}
