import 'dart:math';

import 'package:flame/components.dart';
import 'globals.dart' as globals;

class TileShader extends SpriteComponent {
  double height;
  String asset;
  Vector2 tilePosition;
  double shiftFactor = 0.0001;
  double shiftFactorLinear = 0.00375;
  Vector2 originalSize = Vector2(0, 0);

  TileShader(this.height, this.asset, this.tilePosition);

  Future<void> onLoad() async {
    super.onLoad();
    this
      ..sprite = await Sprite.load(asset)
      ..size = Vector2(64*(1+ height*shiftFactorLinear), 64*(1+ height*shiftFactorLinear))
      ..originalSize = Vector2(64*(1+ height*shiftFactorLinear), 64*(1+ height*shiftFactorLinear))
      ..position = (Vector2(0, -height*4))
      ..priority = height.toInt()
      ..anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    var tileToPlayer = globals.playerPosition - Vector3(tilePosition.x, tilePosition.y, 0);
    tileToPlayer *= shiftFactorLinear;
    // var x = dot3(Vector3(1,0,0),
    //     Vector3(tilePosition.x, tilePosition.y, height)-
    //     Vector3(globals.playerPosition.x, globals.playerPosition.y, globals.cameraCentre.z));
    // var y = dot3(Vector3(0,4,-1).scaled(1),
    //     Vector3(tilePosition.x, tilePosition.y, height)-
    //         Vector3(globals.playerPosition.x, globals.playerPosition.y, globals.cameraCentre.z));
    //position = Vector2(x, y);
    //tileToPlayer.scale(log(1 + tileToPlayer.length*shiftFactor));
    position = -Vector2(tileToPlayer.x, tileToPlayer.y)*height + globals.defaultOffset;
    super.update(dt);
  }
}