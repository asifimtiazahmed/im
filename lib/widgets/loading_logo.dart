import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im/resources/app_assets.dart';
import 'package:provider/provider.dart';

class LoadingLogo extends StatelessWidget {
  const LoadingLogo({Key? key, required this.size}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoadingLogoViewModel>(
      create: (_) => LoadingLogoViewModel(),
      child: Consumer<LoadingLogoViewModel>(
        builder: (_, vm, __) => AnimatedContainer(
          height: size,
          width: size,
          duration: Duration(milliseconds: 20),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.010)
              ..rotateY(vm.angle),
            alignment: FractionalOffset.center,
            child: Image.asset(
              AppAssets.COIN_COLOR,
              key: Key('img'),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingLogoViewModel extends ChangeNotifier {
  late var timer;
  String label = 'dds';
  double angle = 0;

  void addAngle() {
    angle += 0.5;
    notifyListeners();
  }

  void getAngle() {
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      addAngle();
    });
  }

  //INIT
  LoadingLogoViewModel() {
    getAngle();
  }

  @override
  dispose() {
    timer.cancel;
    super.dispose();
  }
}
