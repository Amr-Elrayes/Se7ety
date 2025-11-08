import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sa7ety/components/buttons/custom_buttom.dart';
import 'package:sa7ety/core/routes/navigation.dart';
import 'package:sa7ety/core/routes/routes.dart';
import 'package:sa7ety/core/utils/colors.dart';
import 'package:sa7ety/core/utils/text_styles.dart';
import 'package:sa7ety/services/local/shared_pref.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sa7ety/features/intro/onboarding/model/onboarding_model.dart';

// ignore: must_be_immutable
class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pageController = PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (currentIndex != OnBoardingModel.onBoardingScreens.length - 1)
            TextButton(
              onPressed: () {
                SharedPref.setOnboardingSeen();
                pushAndRemoveUntil(context, Routes.welcome);
              },
              child: Text("تخطي"),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                controller: pageController,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Spacer(),
                      SvgPicture.asset(
                        OnBoardingModel.onBoardingScreens[index].image,
                        width: MediaQuery.sizeOf(context).width * 0.8,
                      ),
                      Spacer(),
                      Text(
                        OnBoardingModel.onBoardingScreens[index].title,
                        style: TextStyles.textSize24.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Gap(10),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          OnBoardingModel.onBoardingScreens[index].subtitle,
                          style: TextStyles.textSize18.copyWith(
                            color: AppColors.darkColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(flex: 3),
                    ],
                  );
                },
                itemCount: OnBoardingModel.onBoardingScreens.length,
              ),
            ),
            Container(
              height: 75,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: OnBoardingModel.onBoardingScreens.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: AppColors.primaryColor,
                      dotColor: AppColors.grayColor,
                    ),
                  ),
                  if (currentIndex ==
                      OnBoardingModel.onBoardingScreens.length - 1)
                    customButtom(
                      width: 100,
                      txt: "هيا بنا",
                      onPressed: () {
                        SharedPref.setOnboardingSeen();
                        pushAndRemoveUntil(context, Routes.welcome);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
