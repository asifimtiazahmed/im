import 'package:flutter/material.dart';
import 'package:im/resources/app_colors.dart';
import 'package:im/resources/app_strings.dart';
import 'package:im/resources/app_styles.dart';
import 'package:im/widgets/custom_top_shape.dart';
import 'package:provider/src/provider.dart';

import 'onboarding_scene_view_model.dart';

class OnboardingForm extends StatelessWidget {
  const OnboardingForm({Key? key}) : super(key: key);
  static const String routeName = 'onboardingForm';

  @override
  Widget build(BuildContext context) {
    final scrSize = MediaQuery.of(context).size;
    final vm = context.watch<OnboardingSceneViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(children: [
              CustomPaint(
                size: Size(scrSize.width, 300),
                painter: TopShape(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 75),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.ONBOARD_CREATE_PROFILE_TITLE,
                      style: AppStyles.title.copyWith(color: AppColors.white),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      AppStrings.ONBOARD_CREATE_PROFILE_CONTENT,
                      style:
                          AppStyles.bodyText.copyWith(color: AppColors.white),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                height: scrSize.height * 0.55,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
