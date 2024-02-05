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
var difficultyModifier = 1.05;
ValueNotifier<int> lives = ValueNotifier<int>(3);