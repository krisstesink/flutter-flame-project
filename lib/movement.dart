import 'dart:math';

import 'package:flame/components.dart';

class Movement {
  Movement();
  Vector2 velocity = Vector2(0, 0);
  Vector2 direction = Vector2(0, 0);
  Vector2 inputDirection = Vector2(0, 0);
  double speed = 200;
  double speedCap = 70.0;
  bool slowing = false;

  void accelCurveKeyboard(bool isW, bool isA, bool isS, bool isD) {
    slowing = false;
    if(!(isW||isA||isS||isD)) {
      slowing = true;
      applyFriction();
      return;
    }
    inputDirection.y = 0; inputDirection.x = 0;

    if(isW) {
      inputDirection.y -= 1;
    }
    if(isA) {
      inputDirection.x -= 1;
    }
    if(isS) {
      inputDirection.y +=1;
    }
    if(isD) {
      inputDirection.x += 1;
    }
    if(inputDirection.x==0 && inputDirection.y==0) {
      applyFriction();
      slowing = true;
      return;
    }
  }

  void applyFriction() {
    if(speed <= 1) {
      speed = 0;
    } else {
      speed = speed - 0.5;
    }
  }
}