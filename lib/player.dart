import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:untitled/player.dart';
import 'package:untitled/playerShader.dart';
import 'package:untitled/worldItems.dart';

import 'movement.dart';

class Player extends SpriteComponent with KeyboardHandler, CollisionCallbacks {
  Movement movement = Movement();
  final hitbox = CircleHitbox(radius: 50, anchor: Anchor.center, position: Vector2(0, -16));

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Rock) {
      if(intersectionPoints.length == 2) {
        final mid = (intersectionPoints.elementAt(0) + intersectionPoints.elementAt(1))/2;
        final collisionNormal = hitbox.absoluteCenter - mid;
        final separationDistance =  hitbox.size.x/2 - collisionNormal.length;

        position += collisionNormal.normalized().scaled(separationDistance);
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    print('we load all game assets from here');
    //load character
    this
      ..sprite = await Sprite.load('character.png')
      ..size = Vector2(1, 1)
      ..anchor = Anchor.center;
    add(
      KeyboardListenerComponent(
        keyUp: {
          LogicalKeyboardKey.keyW: (keysPressed) {
            movement.inputDirection.y += 1;
            return true;
          },
          LogicalKeyboardKey.keyA: (keysPressed) {
            movement.inputDirection.x += 1;
            return true;
          },
          LogicalKeyboardKey.keyS: (keysPressed) {
            movement.inputDirection.y -= 1;
            return true;
          },
          LogicalKeyboardKey.keyD: (keysPressed) {
            movement.inputDirection.x -= 1;
            return true;
          },
        },
        keyDown: {
          LogicalKeyboardKey.keyW: (keysPressed) {
            movement.inputDirection.y = max(movement.inputDirection.y - 1, -1);
            return true;
          },
          LogicalKeyboardKey.keyA: (keysPressed) {
            movement.inputDirection.x = max(movement.inputDirection.x - 1, -1);
            return true;
          },
          LogicalKeyboardKey.keyS: (keysPressed) {
            movement.inputDirection.y = min(movement.inputDirection.y + 1, 1);
            return true;
          },
          LogicalKeyboardKey.keyD: (keysPressed) {
            movement.inputDirection.x = min(movement.inputDirection.x + 1, 1);
            return true;
          },
        },
      ),
    );
    add(PlayerShader(2, "boat0.png"));
    add(PlayerShader(4, "boat1.png"));
    add(PlayerShader(6, "boat2.png"));
    add(PlayerShader(8, "boat3.png"));
    add(PlayerShader(10, "boat4.png"));
    add(PlayerShader(12, "boat5.png"));
    add(PlayerShader(14, "boat6.png"));
    add(PlayerShader(16, "boat7.png"));
    add(hitbox);
  }



  @override
  void update(double dt) {
    super.update(dt);
    var normalizedInput = movement.inputDirection.normalized();
    movement.direction = (movement.direction + normalizedInput)/2;
    position += movement.direction*movement.speed*dt;



    if(movement.slowing) {
      movement.applyFriction();
    }
  }


}