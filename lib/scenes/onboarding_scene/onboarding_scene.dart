import 'package:flutter/material.dart';
import 'package:im/resources/app_colors.dart';
import 'package:im/resources/app_strings.dart';
import 'package:im/resources/app_styles.dart';
import 'package:im/widgets/button.dart';
import 'package:provider/src/provider.dart';
import 'onboarding_scene_view_model.dart';

class OnboardingScene extends StatelessWidget {
  const OnboardingScene({Key? key}) : super(key: key);
  static const String routeName = 'onboardingScene';

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OnboardingSceneViewModel>();
    final scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeIn,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                //IMAGE SECTION
                //if (vm.currentPage == 0)
                AnimatedSwitcher(
                  child: vm.image,
                  duration: Duration(milliseconds: 500),
                  //switchInCurve: Curves.easeIn,
                ),
                const SizedBox(height: 30),
                //TITLE TEXT
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: SizedBox(width: scrWidth * 0.70, child: vm.pageTitle),
                ),
                //CONTENT TEXT
                const SizedBox(height: 10),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child:
                      SizedBox(width: scrWidth * 0.70, child: vm.pageContent),
                ),
                if (vm.currentPage == 1)
                  SizedBox(
                      width: scrWidth * 0.70,
                      child: Text(
                        AppStrings.ONBOARD_CONDITIONS_APPLY,
                        style: AppStyles.subBodyText
                            .copyWith(color: AppColors.white),
                        maxLines: 3,
                      )),
                SizedBox(height: scrWidth * 0.25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: vm.pageIndicator(),
                    ),
                    ActiveButton(
                      onPressed: () => vm.nextPage(context),
                      isCustomBgColor: true,
                      backgroundColor: Colors.white,
                      title: vm.btnTitle,
                      customTextColor: AppColors.primary,
                      width: scrWidth * 0.40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
