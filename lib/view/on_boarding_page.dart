import 'package:animate_do/animate_do.dart';
import 'package:animatedonboarding/model/items_model.dart';
import 'package:animatedonboarding/utils/colorss.dart';
import 'package:animatedonboarding/view/components/components.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // Animation
  Widget animationDo(
    int index,
    int delay,
    Widget child,
  ) {
    if (index == 1) {
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: pageController,
                itemCount: listOfItems.length,
                onPageChanged: (newIndex) {
                  setState(() {
                    currentIndex = newIndex;
                  });
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      children: [
                        // Image
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 40, 15, 10),
                          width: size.width,
                          height: size.height / 2.5,
                          child: animationDo(
                            index,
                            100,
                            Image.asset(
                              listOfItems[index].img,
                            ),
                          ),
                        ),

                        //Title TEXT

                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 15),
                          child: animationDo(
                            index,
                            300,
                            Text(
                              listOfItems[index].title,
                              textAlign: TextAlign.center,
                              style: textTheme.displayLarge,
                            ),
                          ),
                        ),

                        //sub title

                        animationDo(
                          index,
                          500,
                          Text(
                            listOfItems[index].subTitle,
                            textAlign: TextAlign.center,
                            style: textTheme.displayMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ---------------
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: listOfItems.length,
                    effect: const ExpandingDotsEffect(
                      spacing: 6.0,
                      radius: 10.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      expansionFactor: 3.8,
                      dotColor: Colors.grey,
                      activeDotColor: MyColors.btnColor,
                    ),
                    onDotClicked: (newIndex) {
                      setState(() {
                        currentIndex = newIndex;
                        pageController.animateToPage(
                          newIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      });
                    },
                  ),
                  currentIndex == 2
                      ? GetStartBtn(size: size, textTheme: textTheme)
                      : SkipBtn(
                          size: size,
                          textTheme: textTheme,
                          onTap: () {
                            setState(() {
                              pageController.animateToPage(
                                2,
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.fastOutSlowIn,
                              );
                            });
                          })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
