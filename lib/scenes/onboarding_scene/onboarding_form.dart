import 'package:flutter/material.dart';
import 'package:im/resources/app_colors.dart';
import 'package:im/resources/app_strings.dart';
import 'package:im/resources/app_styles.dart';
import 'package:im/widgets/button.dart';
import 'package:im/widgets/custom_top_shape.dart';
import 'package:provider/src/provider.dart';
import 'package:csc_picker/csc_picker.dart';
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
                  child: Form(
                    key: vm.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.OB_NAME, style: AppStyles.subBodyText),
                        const SizedBox(height: 10.0),

                        ///FIRST NAME
                        TextFormField(
                          controller: vm.firstNameController,
                          validator: (value) {
                            if (vm.firstNameController.text.isEmpty) {
                              return AppStrings.OB_ERROR;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: AppStrings.OB_FIRST_NAME,
                            labelStyle: AppStyles.subBodyText.copyWith(
                              color: AppColors.secondaryInactive,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.primary),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        ///LAST NAME
                        TextFormField(
                          controller: vm.lastNameController,
                          validator: (value) {
                            if (vm.lastNameController.text.isEmpty) {
                              return AppStrings.OB_ERROR;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: AppStrings.OB_LAST_NAME,
                            labelStyle: AppStyles.subBodyText.copyWith(
                              color: AppColors.secondaryInactive,
                            ),
                            helperText: AppStrings.OB_NAME_HELPER,
                            helperStyle: AppStyles.subBodyText.copyWith(
                              color: AppColors.secondaryInactive,
                            ),
                            helperMaxLines: 3,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.primary),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(AppStrings.OB_DOB_TITLE,
                            style: AppStyles.subBodyText),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  vm.birthDate,
                                  style: AppStyles.subBodyText.copyWith(
                                      wordSpacing: 2,
                                      letterSpacing: 1.5,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            ActiveButton(
                              title: AppStrings.BTN_SELECT_DATE,
                              isOutlined: true,
                              customTextColor: AppColors.primary,
                              onPressed: () => vm.selectDate(context),
                              width: 150,
                            ),
                          ],
                        ),
                        Text(
                          AppStrings.OB_DOB_HELPER,
                          style: AppStyles.subBodyText
                              .copyWith(color: AppColors.secondaryInactive),
                        ),
                        const SizedBox(height: 30),

                        ///LOCATION
                        Text(AppStrings.OB_CURRENT_LOCATION),
                        const SizedBox(height: 10),
                        CSCPicker(
                          key: vm.countryPiackerKey,
                          showCities: true,
                          showStates: true,
                          flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                          dropdownDecoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: AppColors.primary, width: 1),
                          ),

                          ///placeholders for dropdown search field
                          countrySearchPlaceholder:
                              (vm.country == '') ? "Country" : vm.country,
                          stateSearchPlaceholder:
                              (vm.state == '') ? "State" : vm.state,
                          citySearchPlaceholder:
                              (vm.city == '') ? "City" : vm.city,

                          ///labels for dropdown
                          countryDropdownLabel:
                              (vm.country == '') ? "Country" : vm.country,
                          stateDropdownLabel:
                              (vm.state == '') ? "State" : vm.state,
                          cityDropdownLabel: (vm.city == '') ? "City" : vm.city,
                          onCountryChanged: (value) {
                            print(value);
                            vm.setCountry(value);
                          },
                          onStateChanged: (value) {
                            if (value != null) vm.setState(value);
                          },
                          onCityChanged: (value) {
                            if (value != null) vm.setCity(value);
                          },
                          disabledDropdownDecoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color:
                                  AppColors.secondaryInactive.withOpacity(0.40),
                              border: Border.all(
                                  color: AppColors.primary, width: 1)),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(),
                            ActiveButton(
                              title: AppStrings.BTN_CONTINUE,
                              isCustomBgColor: true,
                              backgroundColor: AppColors.primary,
                              customTextColor: AppColors.white,
                              width: 180,
                              onPressed: () {
                                vm.logOut();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
