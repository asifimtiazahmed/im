import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im/resources/app_assets.dart';
import 'package:im/resources/app_colors.dart';
import 'package:im/resources/app_strings.dart';
import 'package:im/resources/app_styles.dart';
import 'package:im/services/firebase_auth.dart';
import 'package:im/scenes/onboarding_scene/page_indicator.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'onboarding_form.dart';

class OnboardingSceneViewModel extends ChangeNotifier {
  bool isOnboardingDone = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> countryPiackerKey = new GlobalKey<FormState>();
  var dateOfBirth = DateTime.now();
  get birthDate => DateFormat('y MMMM dd').format(dateOfBirth).toString();
  String _country = '';
  String _state = '';
  String _city = '';

  get country => _country;
  get state => _state;
  get city => _city;

  setCountry(String value) {
    if (value.isNotEmpty) _country = value;
    notifyListeners();
  }

  setState(String value) {
    if (value.isNotEmpty) _state = value;
    notifyListeners();
  }

  setCity(String value) {
    if (value.isNotEmpty) _city = value;
    notifyListeners();
  }

  //TODO: Need to update the isOnbaording done value from here onto the authManager instance
//TODO: If google sign in the get the google options like, nick name, image, email etc populated on the form
//TODO: If sign in is facebook or apple then do the same as above
  int currentPage = 0;
  static const int totalPage = 2; //0 ,1, 2 three pages in total
  String btnTitle = AppStrings.BTN_NEXT;
  Widget pageTitle = Text(
    AppStrings.ONBOARD_EASY_ACCESSIBLE_TITLE,
    style: AppStyles.onboardingTitle.copyWith(color: AppColors.white),
    maxLines: 3,
    key: Key('0'),
  );

  @override
  dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

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
        style: AppStyles.onboardingTitle.copyWith(color: AppColors.white),
        maxLines: 3,
        key: Key('0'),
      );
    } else if (currentPage == 1) {
      pageTitle = Text(
        AppStrings.ONBOARD_EVERYONE_CAN_LEARN_TITLE,
        style: AppStyles.onboardingTitle.copyWith(color: AppColors.white),
        maxLines: 3,
        key: Key(currentPage.toString()),
      );
    } else if (currentPage == 2) {
      pageTitle = Text(
        AppStrings.ONBOARD_MUSCOIN_IS_ALL_TITLE,
        style: AppStyles.onboardingTitle.copyWith(color: AppColors.white),
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

  logOut() {
    authManager.sighOut();
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

  selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateOfBirth,
      firstDate: DateTime(1940),
      lastDate: DateTime(DateTime.now().year - 13),
      initialEntryMode: DatePickerEntryMode.input,
      initialDatePickerMode: DatePickerMode.year,
      helpText: AppStrings.BTN_SELECT_DATE,
      fieldHintText: 'Year/Month/Date',
      fieldLabelText: 'Select Date of Birth',
    );
    if (picked != null && picked != dateOfBirth) {
      dateOfBirth = picked;
      notifyListeners();
    }
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != dateOfBirth) {
                  dateOfBirth = picked;
                  notifyListeners();
                }
              },
              initialDateTime: dateOfBirth,
              minimumYear: 1940,
              maximumYear: 2100,
            ),
          );
        });
  }
}
