import 'dart:math';

import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:untitled4/playable%20characters/ship.dart';

import 'movement.dart';
import 'myGame.dart';

void main() {
  print("starting flutter");
  runApp(GameWidget(game: MyGame()));
}

