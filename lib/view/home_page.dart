import 'package:animatedonboarding/utils/colorss.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  bool widthChanged = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );

    animation = Tween<double>(begin: 80, end: 200).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceInOut,
      ),
    );

    controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  buttonClicked() {
    if (widthChanged) {
      widthChanged = false;
      controller.reverse();
    } else {
      widthChanged = true;
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: animation.value,
          height: 80,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(
              color: MyColors.btnBorderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Material(
            color: Colors
                .transparent, // Set to transparent to avoid overlapping colors
            // borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(15), // Apply the same radius to InkWell
              onTap: buttonClicked,
              splashColor: MyColors.btnBorderColor,
              child: const Center(
                child: Text('Click'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
