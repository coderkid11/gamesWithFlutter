// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
    required this.score,
  });

  final ValueNotifier<int> score;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: score,
        builder: (context, score, child) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 18),
            child: Text(
              'Score: $score',
              style: Theme.of(context).textTheme.titleLarge!,
            ),
          );
        }
      );
  }
}
