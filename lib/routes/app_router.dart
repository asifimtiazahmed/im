import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:im/scenes/authenticate_gate_scene/authenticate_gate_view.dart';
import 'package:im/scenes/dashboard/dashboard_scene.dart';
import 'package:im/scenes/dashboard/dashboard_scene_view_model.dart';
import 'package:im/scenes/email_verification/email_verify_scene.dart';
import 'package:im/scenes/email_verification/email_verify_view_model.dart';
import 'package:im/scenes/login/login_scene.dart';
import 'package:im/scenes/onboarding_scene/onboarding_form.dart';
import 'package:im/scenes/onboarding_scene/onboarding_scene.dart';
import 'package:im/scenes/onboarding_scene/onboarding_scene_view_model.dart';
import 'package:im/services/firebase_auth.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final FirebaseAuthManager? _authManager = GetIt.I<FirebaseAuthManager>();

    switch (settings.name) {
      case LoginScene.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginScene(),
        );
      case AuthenticationGateView.routeName:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: _authManager,
            builder: (context, _) => const AuthenticationGateView(),
          ),
        );
      case EmailVerifyScene.routeName:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: EmailVerifyViewModel(),
            builder: (context, _) => const EmailVerifyScene(),
          ),
        );
      case DashboardScene.routeName:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: DashboardViewModel(),
            builder: (context, _) => const DashboardScene(),
          ),
        );
      case OnboardingScene.routeName:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScene(),
        );
      case OnboardingForm.routeName:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: OnboardingSceneViewModel(),
            builder: (context, _) => const OnboardingForm(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: _authManager,
            builder: (context, _) => const AuthenticationGateView(),
          ),
        );
    }
  }
}
