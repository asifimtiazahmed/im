import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'onboarding_scene_view_model.dart';

class OnboardingForm extends StatelessWidget {
  const OnboardingForm({Key? key}) : super(key: key);
  static const String routeName = 'onboardingForm';

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OnboardingSceneViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('onboarding form'),
        ),
      ),
    );
  }
}
