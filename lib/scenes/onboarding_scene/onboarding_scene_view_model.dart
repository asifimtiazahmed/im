import 'package:flutter/material.dart';
import 'package:im/resources/app_assets.dart';
import 'package:im/resources/app_colors.dart';
import 'package:im/resources/app_strings.dart';
import 'package:im/resources/app_styles.dart';
import 'package:im/services/firebase_auth.dart';
import 'package:im/scenes/onboarding_scene/page_indicator.dart';
import 'package:get_it/get_it.dart';

import 'onboarding_form.dart';

class OnboardingSceneViewModel extends ChangeNotifier {
  bool isOnboardingDone = false;

  //TODO: Need to update the isOnbaording done value from here onto the authManager instance
//TODO: If google sign in the get the google options like, nick name, image, email etc populated on the form
//TODO: If sign in is facebook or apple then do the same as above
  int currentPage = 0;
  static const int totalPage = 2; //0 ,1, 2 three pages in total
  String btnTitle = AppStrings.BTN_NEXT;
  Widget pageTitle = Text(
    AppStrings.ONBOARD_EASY_ACCESSIBLE_TITLE,
    style: AppStyles.title.copyWith(color: AppColors.white),
    maxLines: 3,
    key: Key('0'),
  );

  Widget pageContent = Text(
    AppStrings.ONBOARD_EASY_ACCESSIBLE_CONTENT,
    style: AppStyles.bodyText.copyWith(color: AppColors.white),
    maxLines: 3,
    key: Key('0'),
  );

//HELPER
  final authManager = GetIt.I<FirebaseAuthManager>();
  Widget image = Image.asset(AppAssets.ONBOARDING_1, key: Key('0'));
  //INIT
  OnboardingSceneViewModel() {
    currentPage = 0;
    getImage();
    print('\n***** onboarding Scene View Model Initialized ***\n\n ');
  }
  getTitle() {
    if (currentPage == 0) {
      pageTitle = Text(
        AppStrings.ONBOARD_EASY_ACCESSIBLE_TITLE,
        style: AppStyles.title.copyWith(color: AppColors.white),
        maxLines: 3,
        key: Key('0'),
      );
    } else if (currentPage == 1) {
      pageTitle = Text(
        AppStrings.ONBOARD_EVERYONE_CAN_LEARN_TITLE,
        style: AppStyles.title.copyWith(color: AppColors.white),
        maxLines: 3,
        key: Key(currentPage.toString()),
      );
    } else if (currentPage == 2) {
      pageTitle = Text(
        AppStrings.ONBOARD_MUSCOIN_IS_ALL_TITLE,
        style: AppStyles.title.copyWith(color: AppColors.white),
        maxLines: 3,
        key: Key(currentPage.toString()),
      );
    }
  }

  getContent() {
    if (currentPage == 0) {
      pageContent = Text(
        AppStrings.ONBOARD_EASY_ACCESSIBLE_CONTENT,
        style: AppStyles.bodyText.copyWith(color: AppColors.white),
        maxLines: 3,
        key: Key(currentPage.toString()),
      );
    } else if (currentPage == 1) {
      pageContent = Text(
        AppStrings.ONBOARD_EVERYONE_CAN_LEARN_CONTENT,
        style: AppStyles.bodyText.copyWith(color: AppColors.white),
        maxLines: 3,
        key: Key(currentPage.toString()),
      );
    } else if (currentPage == 2) {
      pageContent = Text(
        AppStrings.ONBOARD_MUSCOIN_IS_ALL_CONTENT,
        style: AppStyles.bodyText.copyWith(color: AppColors.white),
        maxLines: 3,
        key: Key(currentPage.toString()),
      );
    }
  }

  getImage() {
    if (currentPage == 0) {
      image = Image.asset(
        AppAssets.ONBOARDING_1,
        key: Key('0'),
      );
    } else if (currentPage == 1) {
      image = Image.asset(AppAssets.ONBOARDING_2, key: Key('1'));
    } else if (currentPage == 2) {
      image = Image.asset(AppAssets.ONBOARDING_3, key: Key('2'));
    }
  }

  //This should be done after the form fill up.
  void onBoardingDone() {
    isOnboardingDone = true;
    authManager.hasCompletedOnboarding = isOnboardingDone;
    notifyListeners();
  }

  List<Widget> pageIndicator() {
    final listOfIndicator = <Widget>[];
    for (int i = 0; i <= totalPage; i++) {
      listOfIndicator.add(
        Padding(
          padding: EdgeInsets.only(left: (i == 0) ? 1.0 : 15.0),
          child: PageIndicator(
            indicatorColor: (i == currentPage)
                ? AppColors.white
                : AppColors.secondaryInactive,
          ),
        ),
      );
    }
    return listOfIndicator;
  }

  nextPage(BuildContext ctx) {
    if (currentPage == 0) {
      currentPage += 1;
      getImage();
      getTitle();
      getContent();
    } else if (currentPage == 1) {
      currentPage += 1;
      getImage();
      getTitle();
      getContent();
      btnTitle = AppStrings.BTN_STARTED;
    } else if (currentPage == 2) {
      Navigator.pushReplacementNamed(ctx, OnboardingForm.routeName);
    }
    notifyListeners();
  }
}
