// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:brick_breaker/src/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../brick_breaker.dart';
import '../config.dart';
import 'overlay_screen.dart';
import 'score_card.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final BrickBreaker game;

  @override
  void initState() {
    super.initState();
    game = BrickBreaker();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
        ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffa9d6e5),
                Color(0xfff2e8cf),
              ],
            ),
          ),
          child: SafeArea(
              child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: IconButton(
                    icon: const Icon(Icons.restart_alt),
                    onPressed: () {
                      game.score.value = 0;
                      lives.value = 3;
                      game.playState = PlayState.welcome;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: Column(
                  children: [
                    ScoreCard(score: game.score),
                    Center(
                      child: ValueListenableBuilder<int>(
                        valueListenable: lives,
                        builder: (context, value, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: value > 0,
                                child: Icon(
                                  LineAwesomeIcons.heart_1,
                                  size: 20,
                                  color: const Color(0xff184e77).withOpacity(0.5),
                                ),
                              ),
                              Visibility(
                                visible: value > 1,
                                child: Icon(
                                  LineAwesomeIcons.heart_1,
                                  size: 20,
                                  color: const Color(0xff184e77).withOpacity(0.5),
                                ),
                              ),
                              Visibility(
                                visible: value > 2,
                                child: Icon(
                                  LineAwesomeIcons.heart_1,
                                  size: 20,
                                  color: const Color(0xff184e77).withOpacity(0.5),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: FittedBox(
                        child: SizedBox(
                          width: game.width,
                          height: game.height,
                          child: GameWidget(
                            game: game,
                            overlayBuilderMap: {
                              PlayState.welcome.name: (context, game) =>
                                  const OverlayScreen(
                                    title: 'TAP TO PLAY',
                                    subtitle: 'User arrow keys or swipe',
                                  ),
                              PlayState.gameOver.name: (context, game) =>
                                  const OverlayScreen(
                                    title: 'G A M E  O V E R',
                                    subtitle: 'Tap to Play Again',
                                  ),
                              PlayState.won.name: (context, game) =>
                                  const OverlayScreen(
                                    title: 'Y O U  W O N ! ! !',
                                    subtitle: 'Tap to Play Again',
                                  ),
                              PlayState.lifeLost.name: (context, game) =>
                                  OverlayScreen(
                                    title: 'L I F E  L O S T',
                                    subtitle:
                                        'You have ${lives.value} lives left',
                                    subtitle2: 'Tap to Continue',
                                  ),
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
