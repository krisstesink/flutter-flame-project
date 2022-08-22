import 'dart:math';

import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:untitled/player.dart';

import 'movement.dart';

class PlayerShader extends SpriteComponent with KeyboardHandler {
  Movement movement = Movement();
  double offset;
  String asset;
  PlayerShader(this.offset, this.asset);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    print('we load all game assets from here');
    //load character
    this
      ..sprite = await Sprite.load(asset)
      ..size = Vector2(85, 85)
      ..position = (Vector2(0, -offset*4))
      ..anchor = Anchor.center;
    add(
      KeyboardListenerComponent(
        keyUp: {
          LogicalKeyboardKey.keyW: (keysPressed) { movement.inputDirection.y += 1; return true;},
          LogicalKeyboardKey.keyA: (keysPressed) { movement.inputDirection.x += 1; return true;},
          LogicalKeyboardKey.keyS: (keysPressed) { movement.inputDirection.y -= 1; return true;},
          LogicalKeyboardKey.keyD: (keysPressed) { movement.inputDirection.x -= 1; return true;},
        },
        keyDown: {
          LogicalKeyboardKey.keyW: (keysPressed) {
            movement.inputDirection.y = max(movement.inputDirection.y-1, -1);
            return true;},
          LogicalKeyboardKey.keyA: (keysPressed) {
            movement.inputDirection.x = max(movement.inputDirection.x-1, -1);
            return true;},
          LogicalKeyboardKey.keyS: (keysPressed) {
            movement.inputDirection.y = min(movement.inputDirection.y+1, 1);
            return true;},
          LogicalKeyboardKey.keyD: (keysPressed) {
            movement.inputDirection.x = min(movement.inputDirection.x+1, 1);
            return true;},
        },
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    var normalizedInput = movement.inputDirection.normalized();
    movement.direction = (movement.direction + normalizedInput)/2;
    angle = Vector2(-movement.direction.x, movement.direction.y).angleToSigned(Vector2(0, -1));
  }
}