import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

var brickColors = [
  const Color(0xfff94144),
  const Color(0xfff3722c),
  const Color(0xfff8961e),
  const Color(0xfff9844a),
  const Color(0xfff9c74f),
  const Color(0xff90be6d),
  const Color(0xff43aa8b),
  const Color(0xff4d908e),
  const Color(0xff277da1),
  const Color(0xff577590),
];

var gameWidth = 820.0;
var gameHeight = 1600.0;
var ballRadius = gameWidth * 0.02;
var batWidth = gameWidth * 0.3;
var batHeight = ballRadius * 2;
var batStep = gameWidth * 0.05;
var brickGutter = gameWidth * 0.015;
var brickWidth =
    (gameWidth - (brickGutter * (brickColors.length + 1))) / brickColors.length;
var brickHeight = gameHeight * 0.03;
ValueNotifier<int> lives = ValueNotifier<int>(3);

var bricksHit = 0;

List<dynamic> difficultyModifier(int level) {
  List<dynamic> value = [0, 0];

  if (bricksHit <= 30) {
    value[0] += 10;
    value[1] += 20;
  } else if (bricksHit <= 40) {
    value[0] += 5;
    value[1] += 10;
  } else if (bricksHit <= 45) {
    value[0] += 2;
    value[1] += 5;
  } else {
    value[0] += 1;
    value[1] += 3;
  }

  if (level == 1) {
    value[0] *= 1.0;
    value[1] *= 1.0;
  } else if (level == 2) {
    value[0] *= 1.05;
    value[1] *= 1.05;
  } else if (level == 3) {
    value[0] *= 1.1;
    value[1] *= 1.1;
  } else if (level == 4) {
    value[0] *= 1.15;
    value[1] *= 1.15;
  } else if (level == 5) {
    value[0] *= 1.2;
    value[1] *= 1.2;
  } else {
    value[0] *= (1.25 * (0.5 * level));
    value[1] *= (1.25 * (0.5 * level));
  }

  log('difficultyModifier: $value');
  return value;
}
