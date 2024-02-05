import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../brick_breaker.dart';
import 'bat.dart';
import 'brick.dart';
import 'play_area.dart';
import '../config.dart';

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<BrickBreaker> {
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
    // required this.difficultyModifier,
  }) : super(
            radius: radius,
            anchor: Anchor.center,
            paint: Paint()
              ..color = const Color(0xff1e6091)
              ..style = PaintingStyle.fill,
            children: [CircleHitbox()]);

  final Vector2 velocity;
  // final List<dynamic> difficultyModifier;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    if (position.x < 0) {
      position.x = 0;
      velocity.x = -velocity.x;
    } else if (position.x > game.width) {
      position.x = game.width;
      velocity.x = -velocity.x;
    }

    if (position.y < 0) {
      position.y = 0;
      velocity.y = -velocity.y;
    } else if (position.y > game.height) {
      add(RemoveEffect(
          delay: 0.2,
          onComplete: () {
            if (lives.value > 1) {
              lives.value--;
              game.playState = PlayState.lifeLost;
            } else {
              lives.value--;
              game.playState = PlayState.gameOver;
            }
          }));
      // game.playState = PlayState.lifeLost;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        add(RemoveEffect(
            delay: 0.35,
            onComplete: () {
              if (lives.value > 1) {
                lives.value--;
                game.playState = PlayState.lifeLost;
              } else {
                lives.value--;
                game.playState = PlayState.gameOver;
              }
            }));
      }
    } else if (other is Bat) {
      velocity.y = -velocity.y;
      velocity.x = velocity.x +
          (position.x - other.position.x) / other.size.x * game.width * 0.3;
    } else if (other is Brick) {
      if (position.y <= other.position.y - other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.y > other.position.y + other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.x <= other.position.x) {
        velocity.x = -velocity.x;
      } else if (position.x > other.position.x) {
        velocity.x = -velocity.x;
      }

      List<dynamic> difficultyModifierList = difficultyModifier(game.level);

      if (velocity.x > 0) {
        velocity.x = velocity.x + difficultyModifierList[0];
      } else {
        velocity.x = velocity.x - difficultyModifierList[0];
      }

      if (velocity.y > 0) {
        velocity.y = velocity.y + difficultyModifierList[1];
      } else {
        velocity.y = velocity.y - difficultyModifierList[1];
      }

      log('velocity: $velocity');
    } else {
      velocity.y = -velocity.y;
    }
  }
}
