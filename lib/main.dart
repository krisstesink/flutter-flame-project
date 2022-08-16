import 'dart:math';

import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:untitled4/player.dart';

import 'movement.dart';

void main() {
  print("starting flutter");
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with KeyboardEvents {
  Movement movement = Movement();
  SpriteComponent player = SpriteComponent();


  @override
  Future<void> onLoad() async {
    super.onLoad();
    print('we load all game assets from here');
    //load character
    player
      ..sprite = await loadSprite('character.png')
      ..size = Vector2(85, 85);
    add(player);
  }
  @override
  void update(double dt) {
    super.update(dt);
    if(player.x < size[0] - player.width) {
      player.position.x += movement.velocity.x*dt;
    }
    if(player.y < size[1] - player.height) {
      player.position.y += movement.velocity.y*dt;
    }
    movement.cycle();
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,
      ) {
    final isKeyDown = event is RawKeyDownEvent;

    final isW = keysPressed.contains(LogicalKeyboardKey.keyW);
    final isA = keysPressed.contains(LogicalKeyboardKey.keyA);
    final isS = keysPressed.contains(LogicalKeyboardKey.keyS);
    final isD = keysPressed.contains(LogicalKeyboardKey.keyD);

    movement.keyEvent(isW, isA, isS, isD);


    if(isKeyDown) {
      return KeyEventResult.handled;
    } else {
      return KeyEventResult.ignored;
    }
  }



}