import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:untitled4/playable%20characters/player.dart';
import 'package:untitled4/tile.dart';

class MyWorld extends World with KeyboardHandler {
  List<Tile> tiles = List.empty(growable: true);
  Player player = Player();

  @override
  Future<void> onLoad() async {
    SpriteComponent background = SpriteComponent();
    background.sprite = await Sprite.load('background0.jpg');
    background.size = Vector2(8000, 4000);

    add(background);

    for (int i = 0; i < 16; i++) {
      for (int j = 0; j < 16; j++) {
        Tile tile = Tile(i, 'grass');
        tile.position = Vector2(i * 64, j * 64);
        add(tile);
      }
    }
    add(player);
  }
}