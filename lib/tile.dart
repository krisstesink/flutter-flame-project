import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:untitled4/tileShader.dart';

class Tile extends SpriteComponent with CollisionCallbacks {
  int layers;
  String prefix;
  Tile(this.layers, this.prefix);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load('grass1.png');
    size = Vector2(1,1);
    super.onLoad();
    for(var i = 0; i<min(layers, 8); i++) {
      add(TileShader((i)*2.roundToDouble(), prefix+i.toString()+".png", position));
    }

  }

}