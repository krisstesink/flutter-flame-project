import 'dart:math';

import 'package:flame/components.dart';

class Movement {
  Movement();
  Vector3 velocity = Vector3(0, 0, 1);
  Vector2 direction = Vector2(0, 0);
  double speed = 0.0;
  var timePressed = 0;
  var timeOn = 60;
  var speedCap = 100;
  bool isW = false; bool isA = false; bool isS = false; bool isD = false;

  void cycle() {
    if(isW||isA||isS||isD) {
      accelCurve(isW, isA, isS, isD);
      timeOn -= 1;
      timeOn = max(0, timeOn);
      if(timeOn == 0) {
        isW = false; isA = false; isS = false;  isD = false;
      }
    } else {
      applyFriction();
    }
  }

  void keyEvent(isW, isA, isS, isD) {
    timeOn = 60;
    this.isW = isW; this.isA = isA; this.isS = isS; this.isD = isD;
  }

  void accelCurve(bool isW, bool isA, bool isS, bool isD) {
    this.isW = isW; this.isA = isA; this.isS = isS; this.isD = isD;

    direction.y = 0; direction.x = 0;

    var initialVelocity = 30.0;
    var curveTime = 4;
    if(isW) {
      direction.y -= 1;
    }
    if(isA) {
      direction.x -= 1;
    }
    if(isS) {
      direction.y +=1;
    }
    if(isD) {
      direction.x += 1;
    }
    if(direction.x==0 && direction.y==0) {
      timePressed = 0;
      applyFriction();
    } else {
      if(timePressed<=curveTime) {
        speed += initialVelocity*(curveTime-timePressed);
        timePressed += 1;
        if(direction.x.abs()>0 && direction.y.abs()>0) {
          velocity.x = sqrt(2)*speed*direction.x;
          velocity.y = sqrt(2)*speed*direction.y;
        } else {
          velocity.x = speed*direction.x;
          velocity.y = speed*direction.y;
        }
      }
    }

  }

  void applyFriction() {
    velocity.x = velocity.x* 0.95; velocity.y = velocity.y*0.95;
  }
}