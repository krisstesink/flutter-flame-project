import 'dart:math';

import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:untitled4/playable%20characters/player.dart';
import 'package:untitled4/playable%20characters/ship.dart';
import 'package:untitled4/tile.dart';
import 'package:untitled4/worldItems.dart';

import 'movement.dart';

class MyGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection, TapDetector {

  @override
  Future<bool> onTapDown(TapDownInfo info) async {
    print(info.eventPosition.game);
    Arrow arrow = Arrow();
    final playerToClick = info.eventPosition.game - player.position;
    arrow
      ..position = player.position
      ..angle = (Vector2(-playerToClick.x, playerToClick.y)).angleToSigned(Vector2(-1, 0))
      ..add(MoveToEffect(player.position + playerToClick.normalized().scaled(arrow.travelDistance), arrow.effectController));
    add(arrow);
    return true;
  }

  @override
  Future<void> onLoad() async {

  }

}