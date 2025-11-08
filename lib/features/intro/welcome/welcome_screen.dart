import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sa7ety/components/buttons/custom_buttom.dart';
import 'package:sa7ety/core/constants/app_images.dart';
import 'package:sa7ety/core/routes/navigation.dart';
import 'package:sa7ety/core/routes/routes.dart';
import 'package:sa7ety/core/utils/colors.dart';
import 'package:sa7ety/core/utils/text_styles.dart';
import 'package:sa7ety/features/auth/models/user_type_enum.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              AppImages.welcome,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اهلا بيك",
                      style: TextStyles.textSize30.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      "سجل و احجز عند دكتورك و انت في البيت",
                      style: TextStyles.textSize15.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 6),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "سجل دلوقتي ك",
                          style: TextStyles.textSize18.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(30),
                        customButtom(
                          txt: "دكتور",
                          txtColor: AppColors.darkColor,
                          onPressed: () {
                            pushTo(context, Routes.login , extra: usertype.doctor);
                          },
                          borderColor: AppColors.borderColor,
                          color: AppColors.borderColor,
                        ),
                        Gap(20),
                        customButtom(
                          txt: "مريض",
                          txtColor: AppColors.darkColor,
                          onPressed: () {
                            pushTo(context, Routes.login , extra: usertype.patient);
                          },
                          borderColor: AppColors.borderColor,
                          color: AppColors.borderColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
