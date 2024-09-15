import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';
import 'package:klondike/klondike_game.dart';
import 'package:klondike/rank.dart';
import 'package:klondike/suit.dart';

class Card extends PositionComponent {
  Card(int intRank, int intSuit)
      : rank = Rank.fromInt(intRank),
        suit = Suit.fromInt(intSuit),
        _faceUp = false,
        super(size: KlondikeGame.cardSize);

  final Rank rank;
  final Suit suit;
  bool _faceUp;

  bool isFaceUp() => _faceUp;
  bool isFaceDown() => !_faceUp;
  void flip() => _faceUp = !_faceUp;

  @override
  String toString() => rank.label + suit.label;

  @override
  void render(Canvas canvas) {
    if (_faceUp) {
      _renderFront(canvas);
    } else {
      _renderBack(canvas);
    }
  }

  void _renderFront(Canvas canvas) {}
  void _renderBack(Canvas canvas) {}
}
