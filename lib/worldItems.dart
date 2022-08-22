

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class Rock extends SpriteComponent {
  @override
  Future<void> onLoad() async {
    this
      ..sprite = await Sprite.load('player.png')
      ..size = Vector2(50, 50)
      ..position = Vector2(100, 100);
    var hitBox = RectangleHitbox();
    hitBox.collisionType = CollisionType.passive;
    add(hitBox);
  }
}

class Arrow extends SpriteComponent with CollisionCallbacks {
  EffectController effectController = EffectController(speed: 1000);
  final travelDistance = 800.0;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Rock) {
      other.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    this
      ..sprite = await Sprite.load('arrow.png')
      ..size = Vector2(50, 10);
    var hitBox = RectangleHitbox();
    hitBox.collisionType = CollisionType.active;
    add(hitBox);
  }
}